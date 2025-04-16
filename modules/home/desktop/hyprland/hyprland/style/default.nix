{ lib
, config
, ...
}:

#TODO - Organise hyprland style config

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  inherit (config.lib.stylix) colors;

  accent = colors.${config.catppuccin.accentBase16};
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        "col.active_border" = lib.mkForce "rgb(${accent})";
      };
      group = {
        "col.border_active" = lib.mkForce "rgb(${accent})";

        groupbar = {
          "col.active" = lib.mkForce "rgb(${accent})";
        };
      };
    };
  };
}
