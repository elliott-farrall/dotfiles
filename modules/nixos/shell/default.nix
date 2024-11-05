{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.shell;
  inherit (cfg) default;

  shells = [ "zsh" ];
in
{
  imports = [
    ./_addons/starship.nix
    ./_addons/tty.nix
  ];

  options = {
    shell.default = lib.mkOption {
      type = lib.types.enum (shells ++ [ "bash" ]);
      default = "bash";
      description = "The default shell to use.";
    };
    shell.extraShells = lib.mkOption {
      type = lib.types.listOf (lib.types.enum shells);
      default = [ ];
      description = "Extra shells to install.";
    };
  };

  config = lib.mkIf (default != "bash") {
    shell.extraShells = [ default ];

    users.defaultUserShell = pkgs.${default};
  };
}
