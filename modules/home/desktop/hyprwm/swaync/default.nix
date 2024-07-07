{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprwm;
  enable = cfg.enable;
in
{
  config = lib.mkIf enable {
    xdg.configFile."swaync/config.json".source = ./config.json;
  };
}
