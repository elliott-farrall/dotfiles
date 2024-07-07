{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    heimdall
  ];

  programs.adb.enable = true;

  home-manager.sharedModules = [
    ({ config, ... }: {
      home.sessionVariables = {
        ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      };

      home.shellAliases = {
        adb = "HOME=${config.xdg.dataHome}/android adb";
      };
    })
  ];
}
