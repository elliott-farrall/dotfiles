{ lib
, format
, config
, host
, ...
}:

#TODO - Automate TailScale tagging

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    age.secrets."tailscale/auth".file = ./auth.age;

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets."tailscale/auth".path;
      extraUpFlags = [ "--ssh" "--hostname" host ];
    };
  };
}
