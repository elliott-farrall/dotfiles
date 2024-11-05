{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.apps.mathematica;
  inherit (cfg) enable;
in
{
  options = {
    apps.remarkable.enable = lib.mkEnableOption "Install reMarkable.";
  };

  config = lib.mkIf enable {
    /* -------------------------------------------------------------------------- */
    /*                                  Packages                                  */
    /* -------------------------------------------------------------------------- */

    home.packages = with pkgs; [
      rmview
      qt5.qtwayland
    ];

    /* -------------------------------------------------------------------------- */
    /*                                   Desktop                                  */
    /* -------------------------------------------------------------------------- */

    xdg.desktopEntries."rmview" = {
      name = "reMarkable";
      comment = "A live viewer for reMarkable written in PyQt5";
      icon = ./icon.jpeg;
      noDisplay = false;

      exec = "${pkgs.rmview}/bin/rmview";
      type = "Application";
    };

    /* -------------------------------------------------------------------------- */
    /*                                Configuration                               */
    /* -------------------------------------------------------------------------- */

    home.sessionVariables = {
      RMVIEW_CONF = pkgs.writeText "rmview.json" (builtins.toJSON {
        ssh = {
          address = "192.168.225.133";
          key = config.age.secrets.remarkable.path;
        };
      });
    };

    /* -------------------------------------------------------------------------- */
    /*                                 Integration                                */
    /* -------------------------------------------------------------------------- */

    wayland.windowManager.hyprland.settings.windowrule = lib.mkIf config.wayland.windowManager.hyprland.enable [
      "tile, title:^(rMview)$"
    ];

    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = lib.mkIf config.programs.waybar.enable {
      "rmview" = "󰐯";
    };
  };
}
