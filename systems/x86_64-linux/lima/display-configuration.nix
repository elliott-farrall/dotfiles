{ lib
, ...
}:

let
  width = 2256;
  height = 1504;

  refresh = 60;

  scale = 1.333333;
in
{
  display = {
    enable = true;
    inherit width height refresh scale;
  };

  home-manager.sharedModules = lib.singleton (
    { config, lib, ... }:
    {
      wayland.windowManager.hyprland.settings.monitor = lib.mkIf config.wayland.windowManager.hyprland.enable [
        "eDP-1, ${toString width}x${toString height}@${toString refresh}, auto, ${toString scale}"
        "desc:Crestron Electronics Inc. Crestron, preferred, auto, auto, mirror, eDP-1"
        "desc:Crestron Electronics Inc. Crestron 420, preferred, auto, auto, mirror, eDP-1"
        "desc: Sony SONY TV, preferred, auto, auto, mirror, eDP-1"
        ", preferred, auto, auto"
      ];
    }
  );
}
