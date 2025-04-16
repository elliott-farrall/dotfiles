{ pkgs
, inputs
, host
, ...
}:

{
  # TODO - Remove custom grafana-to-ntfy module once merged upstream
  disabledModules = [ "services/monitoring/grafana-to-ntfy.nix" ];
  imports = [ ./grafana-to-ntfy.nix ];

  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "http://${host}";
      listen-http = ":2586";
    };
  };

  services.grafana-to-ntfy = {
    enable = true;
    settings = {
      ntfyUrl = "http://${host}:2586/grafana";
      bauthPass = pkgs.writeText "grafana-to-ntfy-pass" (toString (inputs.rand-nix.rng.withSeed "${pkgs.runCommand "uuid" { } "uuidgen > $out"}").int); #TODO - Create lib for random UUIDs
    };
  };
}
