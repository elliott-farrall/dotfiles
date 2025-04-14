{ host
, config
, ...
}:

{
  services.grafana = {
    enable = true;
    settings.server.domain = "${host}.main.dotfiles.elliott-farrall.garnix.me";

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

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain}.locations."/" = {
    proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
    proxyWebsockets = true;
    recommendedProxySettings = true;
  };
}
