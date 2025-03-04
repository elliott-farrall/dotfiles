{ config
, ...
}:

{
  age.secrets."renovate/token".file = ./token.age;

  services.renovate = {
    enable = true;
    credentials.RENOVATE_TOKEN = config.age.secrets."renovate/token".path;
    settings = {
      autodiscover = true;
      onboarding = false;
    };
  };
}
