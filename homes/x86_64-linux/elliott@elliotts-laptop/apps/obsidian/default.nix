{ pkgs
, ...
}:

{

  /* -------------------------------------------------------------------------- */
  /*                                  Packages                                  */
  /* -------------------------------------------------------------------------- */

  home.packages = with pkgs; [
    obsidian
  ];

  /* -------------------------------------------------------------------------- */
  /*                                   Desktop                                  */
  /* -------------------------------------------------------------------------- */

  xdg.desktopEntries."obsidian" = {
    name = "Obsidian";
    comment = "Knowledge base";
    icon = "obsidian";
    noDisplay = false;

    exec = "obsidian %u";
    type = "Application";

    categories = [ "Office" ];
    mimeType = [ "x-scheme-handler/obsidian" ];
  };

  /* -------------------------------------------------------------------------- */
  /*                                  Defaults                                  */
  /* -------------------------------------------------------------------------- */

  xdg.mimeApps.defaultApplications = {
    "text/markdown" = "obsidian.desktop";
  };

  /* -------------------------------------------------------------------------- */
  /*                                 Integration                                */
  /* -------------------------------------------------------------------------- */

  programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = { "obsidian" = ""; };

}
