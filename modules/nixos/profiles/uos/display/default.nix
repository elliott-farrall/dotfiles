{ lib
, config
, ...
}:

let
  cfg = config.profiles.uos;
  enable = cfg.enable && config.display.enable;

  inherit (config.display) output;
in
{
  config = lib.mkIf enable {
    home-manager.sharedModules = lib.singleton ({ config, ... }: {
      wayland.windowManager.hyprland.settings.monitor = lib.mkIf config.wayland.windowManager.hyprland.enable [
        "desc:Crestron Electronics Inc. Crestron, preferred, auto, auto, mirror, ${output}"
        "desc:Crestron Electronics Inc. Crestron 420, preferred, auto, auto, mirror, ${output}"
        "desc: Sony SONY TV, preferred, auto, auto, mirror, ${output}"
      ];
    });
  };
}
