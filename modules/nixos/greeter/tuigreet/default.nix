{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.greeter;
  enable = cfg == "tuigreet";

  inherit (config.services.displayManager.sessionData) desktops;

  accent = config.catppuccin.accentBase16;
in
{
  config = lib.mkIf enable {
    services.greetd.settings.default_session.command = ''${lib.getExe pkgs.greetd.tuigreet} \
      --remember \
      --remember-session \
      --user-menu \
      --session-wrapper '${pkgs.execline}/bin/exec > /dev/null' \
      --sessions ${desktops}/share/wayland-sessions \
      --xsessions ${desktops}/share/xsessions \
      --theme 'border=${accent};prompt=${accent};action=${accent}'
    '';
    #FIXME - Incorrect resolutions on multi-monitor setups
  };
}
