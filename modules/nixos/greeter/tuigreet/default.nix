{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.greeter;
  enable = cfg == "tuigreet";

  inherit (config.services.displayManager.sessionData) desktops;
in
{
  imports = [
    ./logs_fix.nix
  ];

  config = lib.mkIf enable {
    services.greetd.settings.default_session.command = "${lib.getExe pkgs.greetd.tuigreet} --remember --remember-session --user-menu --session-wrapper '${pkgs.execline}/bin/exec > /dev/null' --sessions ${desktops}/share/wayland-sessions --xsessions ${desktops}/share/xsessions";

    # Early KMS
    boot.initrd.kernelModules = [ "i915" ];
  };
}