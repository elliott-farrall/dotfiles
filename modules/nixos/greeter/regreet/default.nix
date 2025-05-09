{ lib
, config
, ...
}:

let
  cfg = config.greeter;
  enable = cfg == "regreet";

  inherit (config.services.displayManager.sessionData) desktops;
in
{
  config = lib.mkIf enable {
    programs.regreet = {
      enable = true;

      cageArgs = [ "-s" "-m" "last" ];

      settings = {
        env.SESSION_DIRS = "${desktops}/share/xsessions:${desktops}/share/wayland-sessions";

        background = {
          path = config.lib.stylix.pixel "base02";
          fit = "Fill";
        };
      };
    };

    stylix.targets.regreet.useWallpaper = false;
  };
}
