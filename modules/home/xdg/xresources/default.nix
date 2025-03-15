{ lib
, config
, osConfig ? null
, ...
}:

let
  cfg = config.xdg;
  enable = cfg.enable && (osConfig.services.xserver.enable or false);
in
{
  config = lib.mkIf enable {
    xresources.path = "${config.xdg.configHome}/X11/xresources";
  };
}
