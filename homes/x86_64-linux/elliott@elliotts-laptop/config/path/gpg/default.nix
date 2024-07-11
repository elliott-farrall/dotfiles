{ config
, ...
}:

{
  home.sessionVariables = {
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
  };
}
