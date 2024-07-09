{ config
, ...
}:

{
  age = {
    secretsDir = "${config.xdg.dataHome}/agenix";
    secretsMountPoint = "${config.xdg.dataHome}/agenix.d";
  };
}
