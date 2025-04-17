{ host
, config
, ...
}:

let
  inherit (config.network) lan-ip dhcp-ip;
in
{
  services.dnsmasq = {
    enable = true;
    settings = {
      server = [ "79.79.79.79" "79.79.79.80" ];

      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;

      cache-size = 1000;

      dhcp-range = [ "br-lan,${dhcp-ip.min},${dhcp-ip.max},24h" ];
      interface = "br-lan";
      dhcp-host = lan-ip;

      local = "/lan/";
      domain = "lan";
      expand-hosts = true;

      no-hosts = true;
      address = "/${host}.lan/${lan-ip}";
    };
  };
}
