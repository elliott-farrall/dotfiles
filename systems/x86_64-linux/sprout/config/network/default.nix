{ config
, ...
}:

let
  inherit (config.network) lan-ip;
in
{
  systemd.network = {
    networks = {
      "10-wan" = {
        matchConfig.Name = "wan";
        networkConfig = {
          DHCP = "ipv4";
          DNSOverTLS = true;
          DNSSEC = true;
          IPv6PrivacyExtensions = false;
          IPForward = true;
        };
        linkConfig.RequiredForOnline = "routable";
      };
      "30-lan0" = {
        matchConfig.Name = "lan0";
        networkConfig = {
          Bridge = "br-lan";
          ConfigureWithoutCarrier = true;
        };
        linkConfig.RequiredForOnline = "enslaved";
      };
      "40-br-lan" = {
        matchConfig.Name = "br-lan";
        bridgeConfig = { };
        address = [
          "${lan-ip}/24"
        ];
        networkConfig = {
          ConfigureWithoutCarrier = true;
        };
      };
    };

    netdevs = {
      "20-br-lan" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "br-lan";
        };
      };
    };
  };
}
