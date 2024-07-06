{ config
, ...
}:

{
  programs.direnv = {
    enable = true;
    config = {
      whitelist.prefix = [
        "${config.xdg.dataHome}/repos"
      ];
    };
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
    DIRENV_WARN_TIMEOUT = 0;
  };
}
