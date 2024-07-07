{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.greeter.gtkgreet;
  enable = cfg.enable;
in
{
  options = {
    greeter.gtkgreet.enable = lib.mkEnableOption "gtkgreet greeter";
  };

  config = lib.mkIf enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "hyprwm";
        };
      };
    };

    users.users.greeter = {
      isSystemUser = lib.mkForce false;
      isNormalUser = true;
    };
    home-manager.users.greeter = {
      gtk.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          exec-once = [
            "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; hyprctl dispatch exit"
          ];
          monitor = [
            "eDP-1, 2256x1504@60, auto, 1.333333"
            ", preferred, auto, auto"
          ];
          input = {
            kb_layout = "gb";
          };
          misc = {
            disable_hyprland_logo = true;
          };
        };
      };
    };
  };
}
