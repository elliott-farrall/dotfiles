{ config
, lib
, ...
}:

{
  age = {
    secretsDir = "${config.xdg.dataHome}/agenix";
    secretsMountPoint = "${config.xdg.dataHome}/agenix.d";
  };

  home.activation.agenix = lib.hm.dag.entryAnywhere config.systemd.user.services.agenix.Service.ExecStart;
}
