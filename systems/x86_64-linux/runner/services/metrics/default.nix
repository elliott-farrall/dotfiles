{ config
, ...
}:

{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.grafana = {
    enable = true;
    settings.server.domain = "runner.main.dotfiles.elliott-farrall.garnix.me";

    provision = {
      enable = true;

      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
        }
      ];
    };
  };
  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations."/" = {
      proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

  services.prometheus = {
    enable = true;

    scrapeConfigs = [
      {
        job_name = "comin";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.comin.exporter.port}" ];
        }];
      }
    ];
  };
}
