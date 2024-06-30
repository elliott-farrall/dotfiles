let
  key_dir = "/run/media/elliott/ESF-USB/Keys";

  elliott = builtins.readFile "${key_dir}/users/elliott/id_ed25519.pub";
  users = [ elliott ];

  elliotts-laptop = builtins.readFile "${key_dir}/systems/elliotts-laptop/ssh_host_ed25519_key.pub";
  systems = [ elliotts-laptop ];

  keys = users ++ systems;
in
{

  /* ------------------------------- GitHub PAT ------------------------------- */

  "homes/x86_64-linux/elliott@elliotts-laptop/config/nix/github-pat.age".publicKeys = keys;

  /* -------------------------------- SSH Keys -------------------------------- */

  "homes/x86_64-linux/elliott@elliotts-laptop/config/ssh/keys/beanmachine.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/ssh/keys/github.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/ssh/keys/python-anywhere.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/ssh/keys/remarkable.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/ssh/keys/uos.age".publicKeys = keys;

  /* ------------------------------ rClone Tokens ----------------------------- */

  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/id-Work.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/id-OneDrive.age".publicKeys = keys;

  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/token-Work.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/token-OneDrive.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/token-Google.age".publicKeys = keys;
  "homes/x86_64-linux/elliott@elliotts-laptop/config/rclone/token-DropBox.age".publicKeys = keys;

}
