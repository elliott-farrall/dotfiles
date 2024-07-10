{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.shell.zsh;
  inherit (cfg) enable;
in
{
  options = {
    shell.zsh.enable = lib.mkEnableOption "zsh shell";
  };

  config = lib.mkIf enable {
    users.defaultUserShell = pkgs.zsh;

    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];
  };
}
