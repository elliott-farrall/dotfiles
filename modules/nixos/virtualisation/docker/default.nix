{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.virtualisation;
  enable = cfg.podman.enable || cfg.docker.enable;
in
{
  config = {
    age.secrets = lib.mkIf enable {
      docker-username.file = ./username.age;
      docker-password.file = ./password.age;
    };

    systemd.services.docker-login = lib.mkIf cfg.docker.enable {
      description = "Docker Login Service";
      after = [ "network.target" ];
      script = ''
        ${pkgs.coreutils}/bin/cat ${config.age.secrets.docker-password.path} | ${pkgs.docker}/bin/docker login --username $(${pkgs.coreutils}/bin/cat ${config.age.secrets.docker-username.path}) --password-stdin
      '';
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services.podman-login = lib.mkIf cfg.podman.enable {
      description = "Podman Login Service";
      after = [ "network.target" ];
      script = ''
        ${pkgs.coreutils}/bin/cat ${config.age.secrets.docker-password.path} | ${pkgs.podman}/bin/podman login --username $(${pkgs.coreutils}/bin/cat ${config.age.secrets.docker-username.path}) --password-stdin
      '';
      wantedBy = [ "multi-user.target" ];
    };

    virtualisation.podman.dockerSocket.enable = true;
  };
}
