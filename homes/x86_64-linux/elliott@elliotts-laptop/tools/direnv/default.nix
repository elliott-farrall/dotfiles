{ ...
}:

{
  programs.direnv.enable = true;

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
    DIRENV_WARN_TIMEOUT = 0;
  };
}
