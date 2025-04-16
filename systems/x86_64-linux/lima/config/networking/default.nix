{ ...
}:

#TODO - Cleanup lima networking config

{
  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 80 443 8443 ];
    firewall.allowedUDPPorts = [ 5901 ]; # rmview
  };
}
