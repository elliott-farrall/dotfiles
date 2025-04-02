{ lib
, pkgs
, config
, ...
}:

{
  age.secrets."renovate/token".file = ./token.age;

  services.renovate = {
    enable = true;
    schedule = "*:0/2"; # Every 2 minutes
    credentials.RENOVATE_TOKEN = config.age.secrets."renovate/token".path;

    runtimePackages = with pkgs; [ bash nix ];

    settings = {
      autodiscover = true;
      autodiscoverFilter = [ "elliott-farrall/*" ];
      onboarding = false;
      allowedCommands = [ ".*" ];
    };
  };

  # baseDir is owned by root
  systemd.services.renovate.serviceConfig = {
    User = lib.mkForce "root";
    Group = lib.mkForce "root";
  };
}
