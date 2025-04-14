{ ...
}:

{
  imports = [
    ./grafana
    ./renovate
  ];

  networking.firewall.allowedTCPPorts = [ 80 ];
  services.nginx.enable = true;
}
