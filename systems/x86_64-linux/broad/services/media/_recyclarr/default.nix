{ ...
}:

{
  age.secrets = {
    sonarr.substitutions = [
      "/etc/broad/recyclarr/config.yaml"
    ];
    radarr.substitutions = [
      "/etc/broad/recyclarr/config.yaml"
    ];
  };

  environment.etc."broad/recyclarr/config.yaml".source = ./config.yaml;
}
