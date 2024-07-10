{ config
, lib
, ...
}:

{

  /* -------------------------------------------------------------------------- */
  /*                                  Packages                                  */
  /* -------------------------------------------------------------------------- */

  programs.vscode = {
    enable = true;
  };

  /* -------------------------------------------------------------------------- */
  /*                                   Desktop                                  */
  /* -------------------------------------------------------------------------- */

  xdg.desktopEntries."code-insiders" = {
    name = "VS Code";
    genericName = "Text Editor";
    comment = "Code editing. Redefined.";
    icon = "vscode-insiders";
    noDisplay = false;

    exec = "code %F";
    type = "Application";
    startupNotify = true;

    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    mimeType = [ "text/plain" "inode/directory" ];

    actions = {
      "new-empty-window" = {
        name = "New Empty Window";
        icon = "vscode-insiders";
        exec = "code --new-window %F";
      };
    };
  };

  xdg.desktopEntries."code-insiders-url-handler" = {
    name = "VS Code URL Handler";
    genericName = "Text Editor";
    comment = "Code editing. Redefined.";
    icon = "vscode-insiders";
    noDisplay = true;

    exec = "code --open-url %U";
    type = "Application";
    startupNotify = true;

    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    mimeType = [ "x-scheme-handler/vscode-insiders" ];
  };

  /* -------------------------------------------------------------------------- */
  /*                                Configuration                               */
  /* -------------------------------------------------------------------------- */

  home.activation.vscodeLinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -e ${config.home.homeDirectory}/.vscode-insiders ]; then
      run rm -r ${config.home.homeDirectory}/.vscode-insiders
    fi
    if [ ! -e ${config.xdg.dataHome}/vscode-insiders ]; then
      run mkdir -p ${config.xdg.dataHome}/vscode-insiders
    fi
    run ln -s ${config.xdg.dataHome}/vscode-insiders ${config.home.homeDirectory}/.vscode-insiders

    if [ -e ${config.home.homeDirectory}/.pki ]; then
      run rm -r ${config.home.homeDirectory}/.pki
    fi
    if [ ! -e ${config.xdg.dataHome}/pki ]; then
      run mkdir -p ${config.xdg.dataHome}/pki
    fi
    run ln -s ${config.xdg.dataHome}/pki ${config.home.homeDirectory}/.pki
  '';

  /* -------------------------------------------------------------------------- */
  /*                                  Defaults                                  */
  /* -------------------------------------------------------------------------- */

  xdg.mimeApps.defaultApplications = (builtins.listToAttrs (map (type: { name = type; value = "code-insiders.desktop"; }) [
    "text/plain"
    "text/html"
    "text/css"
    "text/javascript"
    "application/javascript"
    "application/json"
    "application/xml"
    "application/x-yaml"
    "application/x-python"
    "application/x-php"
    "application/x-ruby"
    "application/x-perl"
    "application/x-shellscript"
    "application/x-csrc"
    "application/x-c++src"
    "application/x-java"
    "application/sql"
  ])) // {
    "application/x-desktop" = "code-insiders-url-handler.desktop";
  };

  /* -------------------------------------------------------------------------- */
  /*                                 Integration                                */
  /* -------------------------------------------------------------------------- */

  programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = { "code" = "󰨞"; };

  /* -------------------------------------------------------------------------- */
  /*                                   Patches                                  */
  /* -------------------------------------------------------------------------- */

  home.shellAliases = {
    code = "NIXOS_OZONE_WL= code"; # Fixes unknown option warinings caused by NIXOS_OZONE_WL=1
  };

}
