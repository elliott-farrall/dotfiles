{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprwm;
  enable = cfg.enable;
in
{
  config = lib.mkIf enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;

        preload = [ "${./wallpaper.jpg}" ];
        wallpaper = [ ",${./wallpaper.jpg}" ];
      };
    };
  };
}
