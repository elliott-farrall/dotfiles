{ pkgs
, config
, ...
}:

{
  age.secrets."renovate/token".file = ./token.age;

  services.renovate = {
    enable = true;
    schedule = "*:0/10"; # Every 10 minutes
    credentials.RENOVATE_TOKEN = config.age.secrets."renovate/token".path;

    runtimePackages = with pkgs; [ nix ];

    settings = {
      autodiscover = true;
      onboarding = false;
      allowedCommands = [ ".*" ];
    };
  };

  systemd.services.renovate.environment.LOG_LEVEL = "debug";
}
