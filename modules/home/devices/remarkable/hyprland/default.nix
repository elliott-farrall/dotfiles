{ config
, lib
, ...
}:

let
  cfg = config.devices.remarkable;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.windowrule = [
      "tile, title:^(rMview)$"
    ];
  };
}
