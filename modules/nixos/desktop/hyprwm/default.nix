{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprwm;
  inherit (cfg) enable;
in
{
  imports = [
    ./greetd.nix
  ];

  options = {
    desktop.hyprwm.enable = lib.mkEnableOption "hyprwm desktop";
  };

  config = lib.mkIf enable {
    assertions = [
      {
        assertion = config.services.pipewire.enable && config.services.pipewire.wireplumber.enable;
        message = "Hyprland requires PipeWire and WirePlumber to be enabled for screensharing";
      }
    ];
  };
}
