{ lib
, pkgs
, ...
}:

let
  exclusions = [
    # shell
    ".bash_profile"
    ".bashrc"
    ".profile"
    ".zshenv"
    # xdg
    ".cache"
    ".config"
    ".local"
    # misc
    ".icons"
    ".ssh"
    # apps
    ".java"
    ".minecraft"
    ".mozilla"
    ".mputils"
    ".pki"
    ".vscode-insiders"
    ".Wolfram"
    ".zotero"
  ];
in
{
  imports = [
    ./adb
    ./docker
    ./gpg
    ./gtk
    ./xdg
    ./xresources
  ];

  systemd.user.services.check_dotfiles = {
    Unit = {
      Description = "Check for dotfiles in the home directory";
    };
    Service = {
      ExecStart = pkgs.writeShellScript "check_dotfiles" ''
        files=$(${pkgs.findutils}/bin/find $HOME -maxdepth 1 -name ".*" ! -name ${lib.strings.concatStringsSep " ! -name " exclusions})

        for file in $files; do
          echo "Found: $(basename "$file")"
        done

        if [ -z "$files" ]; then
          exit 0
        else
          exit 1
        fi
      '';
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
