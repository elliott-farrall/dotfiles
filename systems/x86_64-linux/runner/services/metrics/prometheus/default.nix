{ lib
, inputs
, ...
}:

let
  hosts = inputs.self.nixosConfigurations;
in
{
  services.prometheus.scrapeConfigs = [
    {
      job_name = "comin";
      static_configs = lib.mapAttrsToList
        (host: cfg: {
          targets = [ "${host}:${toString cfg.config.services.comin.exporter.port}" ];
        })
        hosts;
    }
    {
      job_name = "node";
      static_configs = lib.mapAttrsToList
        (host: cfg: {
          targets = [ "${host}:${toString cfg.config.services.prometheus.exporters.node.port}" ];
        })
        hosts;
    }
  ];
}
