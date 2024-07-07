{ pkgs
, ...
}:

{
  security.pam.services.gtklock = { };

  services.systemd-lock-handler.enable = true;

  systemd.user.services.gtklock = {
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
}
