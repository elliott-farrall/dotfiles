{ ...
}:

{
  age.secrets = {
    sonarr.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    radarr.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    prowlarr.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    nzbgeek.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    jellyseerr.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    sabnzbd.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
    password.substitutions = [
      "/etc/broad/buildarr/config.yaml"
    ];
  };

  environment.etc."broad/buildarr/config.yaml".source = ./config.yaml;

  # Hack to fix builarr dependency on jellyseerr
  # systemd.services."podman-jellyseerr-check" = {
  #   serviceConfig = {
  #     Restart = lib.mkForce "no";
  #     Type = lib.mkForce "oneshot";
  #   };
  # };
}
