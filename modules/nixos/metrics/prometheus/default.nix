{ config
, ...
}:

{
  services.prometheus = {
    enable = true;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };

    scrapeConfigs = [
      {
        job_name = "comin";
        static_configs = [{
          targets = [ "localhost:${toString config.services.comin.exporter.port}" ];
        }];
      }
      {
        job_name = "node";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }

    ];
  };
}
