{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprwm;
  inherit (cfg) enable;
in
{
  options = {
    desktop.hyprwm.enable = lib.mkEnableOption "hyprwm desktop";
  };

  config = lib.mkIf enable {
    environment.etc."greetd/environments".text = lib.mkIf config.services.greetd.enable ''
      hyprwm
    '';

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.pathsToLink = [ "/share/xdg-desktop-portal" ]; # https://github.com/nix-community/home-manager/pull/5158#issuecomment-2043764620
  };
}
