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
    home.packages = with pkgs; [ hyprpaper ];

    xdg.configFile."hypr/hyprpaper.conf".text = ''
      splash = false

      preload = ${./wallpaper.jpg}
      wallpaper = ,${./wallpaper.jpg}
    '';
  };
}
