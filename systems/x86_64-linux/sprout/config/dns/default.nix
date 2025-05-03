{ host
, ...
}:

{
  services.dnsmasq = {
    enable = true;

    settings = {
      server = [
        "1.1.1.1" # Cloudflare
        "1.0.0.1" # Cloudflare
        "8.8.8.8" # Google
        "8.8.4.4" # Google
      ];

      local = "/beannet.local/";
      domain = "beannet.local";

      address = [
        "/${host}.beannet.local/10.0.0.1"
      ];

      no-dhcpv6-interface = "lan";

      dhcp-range = [ "set:lan,10.0.0.101,10.0.0.254,255.255.254.0" ];
      dhcp-option = [ "tag:lan,option:dns-server,10.0.0.1" ];
    };
  };

  networking.firewall.interfaces."lan" = {
    allowedUDPPorts = [ 53 67 ];
    allowedTCPPorts = [ 53 ];
  };

  services.resolved.enable = false;
}
