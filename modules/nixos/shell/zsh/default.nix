{ config
, lib
, ...
}:

let
  cfg = config.shell;
  enable = builtins.elem "zsh" cfg.extraShells;
in
{
  imports = [
    ./greetd.nix
  ];

  config = lib.mkIf enable {
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ]; # Allows completion for system packages
  };
}
