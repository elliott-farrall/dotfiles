{ lib
, inputs
, host
, config
, ...
}:

let
  hosts = inputs.self.nixosConfigurations;
in
{
  services.grafana = {
    enable = true;
    settings.server.domain = "${host}.main.dotfiles.elliott-farrall.garnix.me";

    provision = {
      enable = true;

      datasources.settings.datasources = lib.flatten (lib.mapAttrsToList
        (host: cfg: [
          (lib.mkIf cfg.config.services.prometheus.enable {
            name = "Prometheus (${host})";
            type = "prometheus";
            url = "http://${host}:${toString cfg.config.services.prometheus.port}";
          })
          (lib.mkIf cfg.config.services.loki.enable {
            name = "Loki (${host})";
            type = "loki";
            url = "http://${host}:${toString cfg.config.services.loki.configuration.server.http_listen_port}";
          })
        ])
        hosts);
    };
  };

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain}.locations."/" = {
    proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
    proxyWebsockets = true;
    recommendedProxySettings = true;
  };
}
