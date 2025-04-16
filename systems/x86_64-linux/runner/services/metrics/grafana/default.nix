{ host
, config
, ...
}:

{
  services.grafana = {
    enable = true;
    settings = {
      server.domain = "${host}.main.dotfiles.elliott-farrall.garnix.me";
      smtp.enabled = true;
    };

    provision = {
      enable = true;

      alerting.rules.path = ./alerts.yaml;

      alerting.contactPoints.settings.contactPoints = [
        {
          name = "ntfy";
          receivers = [
            {
              uid = "1";
              type = "webhook";
              settings = {
                url = "http://localhost:8000";
                username = config.services.grafana-to-ntfy.settings.bauthUser;
                password = builtins.readFile config.services.grafana-to-ntfy.settings.bauthPass;
              };
            }
          ];
        }
      ];

      datasources.settings.datasources = [
        {
          uid = "1";
          name = "Loki";
          type = "loki";
          url = "http://localhost:${toString config.services.loki.configuration.server.http_listen_port}";
        }
        {
          uid = "2";
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
      ];
    };
  };

  services.nginx.virtualHosts =
    let
      inherit (config.services.grafana.settings.server) domain http_addr http_port;
    in
    {
      ${domain}.locations."/" = {
        proxyPass = "http://${toString http_addr}:${toString http_port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
}
