{ config
, lib
, ...
}:

let
  cfg = config.services.greetd;
  inherit (cfg) enable;
in
{
  environment.etc = lib.mkIf enable {
    "greetd/environments".text = lib.mkAfter "bash";
  };
}
