{ ...
}:

{
  networking = {
    hostName = "elliotts-laptop";
    networkmanager.enable = true;
  };

  # Fix NetworkManager-wait-online.service failing
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    openssh = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
  };
}
