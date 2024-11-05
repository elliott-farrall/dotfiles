{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprwm;
  enable = cfg.enable && config.services.greetd.enable;
in
{
  environment.etc = lib.mkIf enable {
    "greetd/environments".text = lib.mkBefore "hyprwm";
  };
}
