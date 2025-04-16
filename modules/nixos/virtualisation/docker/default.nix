{ lib
, pkgs
, config
, ...
}:

#TODO - Cleanup automated dockerhub login

let
  cfg = config.virtualisation;
  enable = cfg.podman.enable || cfg.docker.enable;
in
{
  config = {
    age.secrets = lib.mkIf enable {
      "docker/username".file = ./username.age;
      "docker/password".file = ./password.age;
    };

    systemd.services.docker-login = lib.mkIf cfg.docker.enable {
      description = "Docker Login Service";
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];

      path = with pkgs; [
        docker
        toybox
      ];

      script = ''
        until ping -qc 1 registry-1.docker.io; do sleep 1; done
        cat ${config.age.secrets."docker/password".path} | docker login --username $(cat ${config.age.secrets."docker/username".path}) --password-stdin
      '';

      wantedBy = [ "multi-user.target" ];
      serviceConfig.Restart = "on-failure";
    };

    systemd.services.podman-login = lib.mkIf cfg.podman.enable {
      description = "Podman Login Service";
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];

      path = with pkgs; [
        podman
        toybox
      ];

      script = ''
        until ping -qc 1 registry-1.docker.io; do sleep 1; done
        cat ${config.age.secrets."docker/password".path} | podman login --username $(cat ${config.age.secrets."docker/username".path}) --password-stdin
      '';

      wantedBy = [ "multi-user.target" ];
      serviceConfig.Restart = "on-failure";
    };

    virtualisation.podman.dockerSocket.enable = cfg.podman.enable;
  };
}
