{ config
, lib
, ...
}:

let
  cfg = config.networking.networkmanager;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    age.secrets.uos-env.file = ./env.age;

    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ config.age.secrets.uos-env.path ];
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
          identity = "es00569@surrey.ac.uk";
          password = "$UOS_PASSWORD";
          phase2-auth = "mschapv2";
        };
      };
    };
  };
}
