{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.locker.gtklock;
  enable = cfg.enable;
in
{
  options = {
    locker.gtklock.enable = lib.mkEnableOption "gtklock screen locker";
  };

  config = lib.mkIf enable {
    services.systemd-lock-handler.enable = true;

    systemd.user.services.systemd-lock-handler-gtklock = {
      unitConfig = {
        Description = "Screen locker for Wayland";
        OnSuccess = "unlock.target";
        PartOf = "lock.target";
        After = "lock.target";
      };
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.gtklock}/bin/gtklock";
        Restart = "on-failure";
        RestartSec = 0;
      };
      wantedBy = [ "lock.target" ];
    };

    security.pam.services.gtklock = { };
  };
}
