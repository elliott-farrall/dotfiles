{ host
, ...
}:

{
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };

  # Fix NetworkManager-wait-online.service failing
  # systemd.services.NetworkManager-wait-online.enable = false;
}
