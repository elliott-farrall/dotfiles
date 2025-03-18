{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.greeter;
  enable = cfg == "tuigreet";
in
{
  # imports = [
  #   ./logs_fix.nix
  # ];

  config = lib.mkIf enable {
    services.greetd.settings.default_session.command = "${lib.getExe pkgs.kmscon} -l -- ${lib.getExe pkgs.greetd.tuigreet}";
    systemd.services."autovt@tty1".enable = lib.mkForce true;
  };
}
