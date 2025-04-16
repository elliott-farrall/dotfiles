{ lib
, config
, ...
}:

#TODO - implement dynamic wallpaper

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    services.hyprpaper.enable = true;
  };
}
