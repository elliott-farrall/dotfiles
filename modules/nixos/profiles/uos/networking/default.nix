{ config
, lib
, ...
}:

let
  cfg = config.profiles.uos;
  enable = cfg.enable && config.networking.networkmanager.enable;
in
{
  config = lib.mkIf enable {
    age.secrets."profiles/uos/env".file = ./env.age;

    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ config.age.secrets."profiles/uos/env".path ];
      profiles.eduroam = {
        connection = {
          id = "eduroam";
          uuid = "6f750d2a-845d-45e9-aa65-17a23736aff4";
          type = "wifi";
          permissions = "user:elliott:;";
        };
        wifi = {
          ssid = "eduroam";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };
        "802-1x" = {
          eap = "peap";
          identity = "$UOS_USERNAME";
          password = "$UOS_PASSWORD";
          phase2-auth = "mschapv2";
        };
      };
    };
  };
}
