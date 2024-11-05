{ config
, lib
, pkgs
, inputs
, ...
}:

let
  cfg = config.greeter;
  enable = cfg != "";
in
{
  options = {
    greeter = lib.mkOption {
      type = lib.types.enum [
        "gtkgreet"
        ""
      ];
      default = "";
      description = "The greeter to use.";
    };
  };

  config = lib.mkIf enable {
    services.greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.hyprland}/bin/Hyprland > /dev/null 2>&1";
    };

    users.users.greeter = {
      isSystemUser = lib.mkForce false;
      isNormalUser = lib.mkForce true;
    };
    home-manager.users.greeter = {
      imports = with inputs; [
        catnerd.homeModules.catnerd
      ];
      inherit (config) catnerd;
      gtk.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          inherit (config.home-manager.users.elliott.wayland.windowManager.hyprland.settings) monitor;
          misc.disable_hyprland_logo = true;
        };
      };
    };
  };
}
