{ host
, config
, ...
}:

let
  inherit (config.services.grafana.settings) server;
in
{
  services.grafana = {
    enable = true;
    settings = {
      server.domain = "${host}.main.dotfiles.elliott-farrall.garnix.me";
      smtp.enabled = true;
    };

    provision = {
      enable = true;

      datasources.settings.datasources = [
        {
          name = "Loki";
          type = "loki";
          url = "http://localhost:${toString config.services.loki.configuration.server.http_listen_port}";
        }
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
      ];
    };
  };

  services.nginx.virtualHosts.${server.domain}.locations."/" = {
    proxyPass = "http://${toString server.http_addr}:${toString server.http_port}";
    proxyWebsockets = true;
    recommendedProxySettings = true;
  };
}
