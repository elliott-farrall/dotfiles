{ config
, lib
, pkgs
, ...
}:

let
  id = "tvqk3odd";
in
{

  /* -------------------------------------------------------------------------- */
  /*                                  Packages                                  */
  /* -------------------------------------------------------------------------- */

  home.packages = with pkgs; [
    zotero_7
  ];

  /* -------------------------------------------------------------------------- */
  /*                                   Desktop                                  */
  /* -------------------------------------------------------------------------- */

  xdg.desktopEntries."zotero" = {
    name = "Zotero";
    genericName = "Reference Management";
    comment = "Collect, organize, cite, and share your research sources";
    icon = "zotero";
    noDisplay = false;

    exec = "zotero -url %U";
    type = "Application";
    startupNotify = true;

    categories = [ "Office" "Database" ];
    mimeType = [ "x-scheme-handler/zotero" "text/plain" ];
  };

  /* -------------------------------------------------------------------------- */
  /*                                Configuration                               */
  /* -------------------------------------------------------------------------- */

  xdg.configFile."zotero/profiles.ini" = {
    text = ''
      [General]
      StartWithLastProfile=1

      [Profile0]
      Name=default
      IsRelative=1
      Path=${id}.default
      Default=1
    '';
    force = true;
  };

  xdg.configFile."zotero/${id}.default/user.js" = {
    text = ''
      user_pref("extensions.zotero.dataDir", "${config.xdg.dataHome}/zotero");
    '';
  };

  home.activation.zoteroLinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -e ${config.home.homeDirectory}/.zotero ]; then
      run rm -r ${config.home.homeDirectory}/.zotero
    fi
    run ln -s ${config.xdg.configHome} ${config.home.homeDirectory}/.zotero

    if [ -e ${config.home.homeDirectory}/.mozilla ]; then
      run rm -r ${config.home.homeDirectory}/.mozilla
    fi
    if [ ! -e ${config.xdg.dataHome}/mozilla ]; then
      run mkdir -p ${config.xdg.dataHome}/mozilla
    fi
    run ln -s ${config.xdg.dataHome}/mozilla ${config.home.homeDirectory}/.mozilla
  '';

  /* -------------------------------------------------------------------------- */
  /*                                 Integration                                */
  /* -------------------------------------------------------------------------- */

  wayland.windowManager.hyprland.settings.windowrulev2 = [ "float, class:(Zotero), title:(Progress)" ];

  programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = { "zotero" = "󰰸"; };

}
