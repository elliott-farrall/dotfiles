{ lib
, format
, ...
}:

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    services.prometheus = {
      enable = true;

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
        };
      };
    };
  };
}
