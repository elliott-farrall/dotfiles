{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.shell;
in
{
  imports = [
    ./prompt.nix
  ];

  options = {
    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "zsh" ];
      default = "zsh";
      description = "The shell to use.";
    };
  };

  config = lib.mkIf (cfg != "bash") {
    users.defaultUserShell = pkgs.${cfg};
  };
}
