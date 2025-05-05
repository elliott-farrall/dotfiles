{ lib
, config
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    programs.hyprlock.enable = true;

    stylix.targets.hyprlock.useWallpaper = false;
  };
}
