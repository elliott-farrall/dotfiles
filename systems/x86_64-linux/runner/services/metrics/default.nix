{ config
, ...
}:

let
  inherit (config.services.grafana.settings) server;
in
{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.grafana = {
    enable = true;
    settings.server.domain = "runner.main.dotfiles.elliott-farrall.garnix.me";
  };
  services.nginx.virtualHosts.${server.domain} = {
    locations."/" = {
      proxyPass = "http://${toString server.http_addr}:${toString server.http_port}";
      proxyWebsockets = true;
    };
  };

  services.prometheus.enable = true;
}
