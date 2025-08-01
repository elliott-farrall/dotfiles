{ ...
}:

{
  networking.networkmanager.enable = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "561b011a2752dfda" ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;

    publish = {
      enable = true;
      addresses = true;
    };
  };
}
