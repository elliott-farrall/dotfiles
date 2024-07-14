{ config
, ...
}:

{
  programs.direnv = {
    enable = true;
    silent = true;
    config = {
      global.warn_timeout = 0;
      whitelist.prefix = [
        "${config.xdg.dataHome}/repos"
      ];
    };
    nix-direnv.enable = true;
  };
}
