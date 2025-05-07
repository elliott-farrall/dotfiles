{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.virtualisation;
  enable = cfg.podman.enable || cfg.docker.enable;

  mkLoginService = backend: {
    description = "${lib.internal.capitalise backend} Login Service";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    path = [
      cfg.${backend}.package
      pkgs.toybox
    ];

    script = ''
      until ping -4qc 1 login.docker.com; do sleep 1; done
      cat ${config.age.secrets."docker/password".path} | ${backend} login --username $(cat ${config.age.secrets."docker/username".path}) --password-stdin
    '';

    wantedBy = [ "multi-user.target" ];
    serviceConfig.Restart = "on-failure";
  };
in
{
  config = {
    age.secrets = lib.mkIf enable {
      "docker/username".file = ./username.age;
      "docker/password".file = ./password.age;
    };

    systemd.services = {
      docker-login = lib.mkIf cfg.docker.enable (mkLoginService "docker");
      podman-login = lib.mkIf cfg.podman.enable (mkLoginService "podman");
    };

    virtualisation.podman.dockerSocket.enable = cfg.podman.enable;
  };
}
