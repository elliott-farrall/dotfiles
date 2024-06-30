{ config
, ...
}:

{
  xresources.path = "${config.xdg.configHome}/X11/xresources";
}
