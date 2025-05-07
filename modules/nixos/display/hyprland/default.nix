{ config
, lib
, ...
}:

let
  cfg = config.display;
  inherit (cfg) enable;

  inherit (cfg) output width height refresh scale;
in
{
  config = lib.mkIf enable {
    home-manager.sharedModules = lib.singleton ({ config, ... }: {
      wayland.windowManager.hyprland.settings.monitor = lib.mkIf config.wayland.windowManager.hyprland.enable [
        "${output}, ${toString width}x${toString height}@${toString refresh}, auto, ${toString scale}"
        ", preferred, auto, auto"
      ];
    });
  };
}
