{ config
, lib
, pkgs
, inputs
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
          command = "${pkgs.cage}/bin/cage -m last ${pkgs.greetd.gtkgreet}/bin/gtkgreet";
        };
      };
    };

    users.users.greeter = {
      isSystemUser = lib.mkForce false;
      isNormalUser = true;
    };
    home-manager.users.greeter = {
      imports = with inputs; [
        catnerd.homeModules.catnerd
      ];
      inherit (config) catnerd;

      gtk.enable = true;
    };
  };
}
