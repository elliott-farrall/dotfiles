{ config
, ...
}:

{
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
}
