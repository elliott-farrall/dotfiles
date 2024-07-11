{ config
, ...
}:

{
  home.sessionVariables = {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
  };

  home.shellAliases = {
    adb = "HOME=${config.xdg.dataHome}/android adb";
  };
}
