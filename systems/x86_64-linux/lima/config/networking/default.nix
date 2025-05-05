{ ...
}:

{
  networking = {
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 5901 ]; # rmview
  };
}
