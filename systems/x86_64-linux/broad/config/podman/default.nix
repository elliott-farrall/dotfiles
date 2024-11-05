{ config
, lib
, ...
}:

let
  inherit (config.virtualisation.podman) enable;
in
{
  config = lib.mkIf enable {
    networking.firewall.interfaces.podman1.allowedUDPPorts = [ 53 ];
  };
}
