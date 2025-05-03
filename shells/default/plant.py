#! /usr/bin/env nix
#! nix shell
#! nix nixpkgs#bitwarden-cli
#! nix nixpkgs#nixos-anywhere
#! nix nixpkgs#python3
#! nix --command python3

import argparse
import getpass
import json
import logging
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import itertools
import threading
from pathlib import Path
from time import sleep
from typing import Dict, Optional


FLAKE = os.getcwd()
ARCH = "x86_64-linux"
PERSIST_PATH = "persist"


clear_prev = lambda: print("\033[F\033[K\033[F")


class Spinner:
    def __init__(self, message="Processing"):
        self.message = message
        self.spinner_chars = ["⢿", "⣻", "⣽", "⣾", "⣷", "⣯", "⣟", "⡿"]
        self.spinner_running = False
        self.thread = None

    def _spin(self):
        for char in itertools.cycle(self.spinner_chars):
            if not self.spinner_running:
                break
            logging.info(f"{self.message} {char}")
            sleep(0.1)
            clear_prev()

    def __enter__(self):
        self.spinner_running = True
        self.thread = threading.Thread(target=self._spin)
        self.thread.start()

    def __exit__(self, exc_type, exc_value, traceback):
        self.spinner_running = False
        self.thread.join()
        clear_prev()


class Bitwarden:
    def __init__(self):
        self.email: Optional[str] = None
        self.password: Optional[str] = None
        self.session: Optional[str] = None

    def __enter__(self) -> "Bitwarden":
        self.login()
        self.unlock()
        return self

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        self.lock()

    def ask_input(self, prompt: str) -> str:
        output = input(prompt)
        clear_prev()
        return output

    def ask_secret(self, prompt: str) -> str:
        output = getpass.getpass(prompt)
        clear_prev()
        return output

    @property
    def is_logged_in(self) -> bool:
        try:
            status_output = subprocess.check_output(["bw", "status"], text=True)
            logging.debug(f"Bitwarden status output: {status_output}")
            return '"status":"unauthenticated"' not in status_output
        except subprocess.CalledProcessError as e:
            logging.error(f"Error checking Bitwarden login status: {e}")
            return False

    def login(self):
        if not self.is_logged_in:
            logging.info("Starting Bitwarden login...")
            self.email = self.ask_input("Enter your Bitwarden email: ")
            self.password = self.ask_secret("Enter your Bitwarden master password: ")
            auth_code = self.ask_input("Enter your Bitwarden 2FA code (if applicable): ")

            try:
                login_output = subprocess.check_output(
                    ["bw", "login", self.email, "--raw", "--method", "0", "--code", auth_code],
                    input=self.password,
                    text=True,
                    stderr=subprocess.DEVNULL,
                )
                self.session = login_output.strip()
                logging.debug(f"Bitwarden session token: {self.session}")
            except subprocess.CalledProcessError as e:
                logging.exception("Error during Bitwarden login")
                raise RuntimeError("Failed to log into Bitwarden.")
        else:
            logging.info("Bitwarden login already active.")

    @property
    def is_unlocked(self) -> bool:
        try:
            status_output = subprocess.check_output(["bw", "status"], text=True)
            logging.debug(f"Bitwarden vault status output: {status_output}")
            return '"status":"locked"' not in status_output
        except subprocess.CalledProcessError as e:
            logging.error(f"Error checking Bitwarden vault status: {e}")
            return False

    def unlock(self):
        if not self.is_unlocked:
            logging.info("Starting Bitwarden vault unlock...")

            if not self.password:
                self.password = self.ask_secret("Enter your Bitwarden master password: ")

            try:
                unlock_output = subprocess.check_output(
                    ["bw", "unlock", "--raw"],
                    input=self.password,
                    text=True,
                    stderr=subprocess.DEVNULL,
                )
                self.session = unlock_output.strip()
                logging.debug(f"Bitwarden session token after unlock: {self.session}")
                logging.info("Bitwarden vault unlocked.")
            except subprocess.CalledProcessError as e:
                logging.error(f"Error during Bitwarden vault unlock: {e}")
                raise RuntimeError("Failed to unlock Bitwarden vault.")
        else:
            logging.debug("Bitwarden vault is already unlocked.")

    def lock(self):
        logging.info("Relocking Bitwarden vault...")
        try:
            subprocess.run(["bw", "lock"], check=True, stdout=subprocess.DEVNULL)
        except subprocess.CalledProcessError as e:
            logging.error(f"Error relocking Bitwarden vault: {e}")
            raise RuntimeError("Failed to relock Bitwarden vault.")

    def get_key(self, host: str, key_type: str = "private", key_format: str = "ed25519") -> str:
        logging.info(f"Getting {key_type} {key_format} key for {host} from Bitwarden...")
        try:
            raw_output = subprocess.check_output(
                ["bw", "get", "item", f"{host} - {key_format}"],
                env={**os.environ, "BW_SESSION": self.session},
                text=True,
            )
            logging.debug(f"Raw output from Bitwarden for {host}: {raw_output}")
            match key_type:
                case "private":
                    key = json.loads(raw_output)["sshKey"]["privateKey"]
                case "public":
                    key = json.loads(raw_output)["sshKey"]["publicKey"]
                case _:
                    raise ValueError(f"Invalid key type: {key_type}")
            return key
        except (subprocess.CalledProcessError, KeyError, json.JSONDecodeError) as e:
            logging.error(f'Error fetching {key_type} {key_format} key for host "{host}": {e}')
            raise RuntimeError(f"Failed to fetch keys for {host}.")


class TemporaryKey:
    def __init__(self, key_content: str):
        self.key_content: str = key_content
        self.key_path: Optional[Path] = None

    def __enter__(self) -> Path:
        temp_key = tempfile.NamedTemporaryFile(delete=False)
        try:
            temp_key_path = Path(temp_key.name)
            temp_key_path.write_text(self.key_content)
            temp_key_path.chmod(0o600)
            logging.info(f"Temporary key created at {temp_key_path}")
            self.key_path = temp_key_path
        except Exception as e:
            logging.error(f"Error creating temporary key: {e}")
            raise RuntimeError("Failed to create temporary key.")
        return self.key_path

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        """Remove the temporary key file."""
        if self.key_path and self.key_path.exists():
            self.key_path.unlink()
            logging.info(f"Temporary key {self.key_path} removed.")


class TemporaryDirectory:
    def __init__(self, keys: Dict[str, str]):
        self.keys: Dict[str, str] = keys
        self.dir_path: Optional[Path] = None

    def __enter__(self) -> Path:
        temp_dir = Path(tempfile.mkdtemp())
        try:
            ssh_dir = temp_dir / PERSIST_PATH / "etc" / "ssh"
            ssh_dir.mkdir(parents=True, mode=0o700)

            for key_name, key_content in self.keys.items():
                key_path = ssh_dir / key_name
                key_path.write_text(key_content)
                key_path.chmod(0o700)

            logging.info(f"Temporary directory structure created at {temp_dir}")
            self.dir_path = temp_dir
        except Exception as e:
            if temp_dir.exists():
                shutil.rmtree(temp_dir)
            logging.error(f"Error setting up temporary directory for keys: {self.keys}. Exception: {e}")
            raise RuntimeError("Failed to create temporary directory.")
        return self.dir_path

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        if self.dir_path and self.dir_path.exists():
            shutil.rmtree(self.dir_path)
            logging.info(f"Temporary directory {self.dir_path} removed.")


def install(src: str, dst: str, identity: Path, files: Path, dry_run: bool = False) -> None:
    try:
        if dry_run:
            logging.info("Dry run enabled. Skipping actual installation.")
        else:
            logging.info("Starting NixOS installation...")

        with Spinner("Installing NixOS"):
            if dry_run:
                sleep(5)
            else:
                subprocess.run(
                    [
                        "nixos-anywhere",
                        "-i",
                        str(identity),
                        "--generate-hardware-config",
                        f"nixos-facter {FLAKE}/systems/{ARCH}/{src}/system/hardware.json",
                        "--extra-files",
                        str(files),
                        "--flake",
                        f"{FLAKE}#{src}",
                        "--target-host",
                        f"root@{dst}",
                    ],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                    check=True,
                )

        logging.info("NixOS installation completed successfully.")
    except subprocess.CalledProcessError as e:
        logging.error(f"Error during NixOS Anywhere installation: {e}")
        exit(1)


def main() -> int:
    parser = argparse.ArgumentParser(description="Remote installer script for NixOS.")
    parser.add_argument("host", help="The name of the host to install.")
    parser.add_argument("-d", "--dest", default=None, help="The destination for the installation.")
    parser.add_argument("--debug", action="store_true", help="Enable debug logging.")
    parser.add_argument("--dry-run", action="store_true", help="Enable dry run mode (no actual installation).")
    args = parser.parse_args()

    log_level = logging.DEBUG if args.debug else logging.INFO
    logging.basicConfig(
        level=log_level, format="%(asctime)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S"
    )

    host: str = args.host
    dest: str = args.dest or socket.gethostbyname(host)

    try:
        with Bitwarden() as bw:
            dest_key: str = bw.get_key("root")
            host_keys: Dict[str, str] = {
                "ssh_host_ed25519_key": bw.get_key(host, key_type="private", key_format="ed25519"),
                "ssh_host_ed25519_key.pub": bw.get_key(host, key_type="public", key_format="ed25519"),
                "ssh_host_rsa_key": bw.get_key(host, key_type="private", key_format="rsa"),
                "ssh_host_rsa_key.pub": bw.get_key(host, key_type="public", key_format="rsa"),
            }

            with TemporaryKey(dest_key) as temp_key, TemporaryDirectory(host_keys) as temp_dir:
                install(host, dest, temp_key, temp_dir, dry_run=args.dry_run)

        return 0
    except RuntimeError as e:
        logging.error(f"Critical error: {e}")
        return 1
    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
