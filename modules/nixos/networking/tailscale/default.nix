{ lib
, format
, config
, host
, ...
}:

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    age.secrets."tailscale/auth".file = ./auth.age;

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets."tailscale/auth".path;
      extraUpFlags = [ "--hostname" host "--advertise-tags" "tag:node" "--ssh" ];
    };
  };
}
