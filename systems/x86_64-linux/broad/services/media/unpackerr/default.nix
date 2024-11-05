{ ...
}:

{
  age.secrets = {
    sonarr.substitutions = [
      "/etc/broad/unpackerr/config.conf"
    ];
    radarr.substitutions = [
      "/etc/broad/unpackerr/config.conf"
    ];
    prowlarr.substitutions = [
      "/etc/broad/unpackerr/config.conf"
    ];
  };

  environment.etc."broad/unpackerr/config.conf".source = ./config.conf;
}
