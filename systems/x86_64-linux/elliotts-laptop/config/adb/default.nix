{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    heimdall
  ];

  programs.adb.enable = true;

  environment.sessionVariables = {
    ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
  };

  environment.shellAliases = {
    adb = "HOME=$XDG_DATA_HOME/android adb";
  };
}
