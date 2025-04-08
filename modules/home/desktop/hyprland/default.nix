{ lib
, pkgs
, config
, osConfig ? null
, ...
}:

#TODO - Build AGS widgets

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "hyprland desktop";
  };

  config = lib.mkIf enable {
    assertions = [
      {
        assertion = osConfig.services.pipewire.enable or true;
        message = "Hyprland requires PipeWire to be enabled for screensharing";
      }
      {
        assertion = osConfig.services.pipewire.wireplumber.enable or true;
        message = "Hyprland requires WirePlumber to be enabled for screensharing";
      }
    ];

    home.sessionVariables.NIXOS_OZONE_WL = 1;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ hyprland ];
    };
  };
}
