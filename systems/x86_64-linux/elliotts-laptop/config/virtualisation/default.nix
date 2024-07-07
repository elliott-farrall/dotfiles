{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    quickemu
  ];

  virtualisation = {
    docker.enable = true;

    spiceUSBRedirection.enable = true;
  };

  home-manager.sharedModules = [
    ({ config, ... }: {
      home.sessionVariables = {
        DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      };
    })
  ];
}
