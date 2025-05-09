{ lib
, inputs
, format
, host
, ...
}:

#TODO - Migtrate from promtail to grfana-alloy

let
  enable = format == "linux";

  inherit (inputs.self.nixosConfigurations) runner;
in
{
  config = lib.mkIf enable {
    # Inspired by
    # https://gist.github.com/rickhull/895b0cb38fdd537c1078a858cf15d63e

    services.promtail = {
      enable = true;

      configuration = {
        server = {
          http_listen_port = 3031;
          grpc_listen_port = 0;
        };

        positions = {
          filename = "/tmp/positions.yaml";
        };

        clients = [
          {
            url = "http://runner:${toString runner.config.services.loki.configuration.server.http_listen_port}/loki/api/v1/push";
          }
        ];

        scrape_configs = [
          {
            job_name = "journal";
            journal = {
              max_age = "12h";
              labels = {
                inherit host;
                job = "systemd-journal";
              };
            };
            relabel_configs = [
              {
                source_labels = [ "__journal__systemd_unit" ];
                target_label = "unit";
              }
            ];
          }
        ];
      };
    };
  };
}
