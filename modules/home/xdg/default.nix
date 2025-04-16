{ lib
, pkgs
, config
, ...
}:

#TODO - Needs a lot of work

let
  inherit (config.home) homeDirectory;
  inherit (config.xdg) dataHome;

  inherit (lib.home-manager.hm.dag) entryAfter;
in
{
  home.packages = [ pkgs.xdg-ninja ];

  xdg = {
    enable = true;

    cacheHome = "${homeDirectory}/.cache";
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    stateHome = "${homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "${homeDirectory}/Desktop";
      documents = "${homeDirectory}/Documents";
      download = "${homeDirectory}/Downloads";
      music = "${homeDirectory}/Music";
      pictures = "${homeDirectory}/Pictures";
      publicShare = "${homeDirectory}/Public";
      templates = "${homeDirectory}/Templates";
      videos = "${homeDirectory}/Videos";

      extraConfig = {
        XDG_REPO_DIR = "${homeDirectory}/Repositories";
        XDG_REMOTE_DIR = "${homeDirectory}/Remotes";
      };
    };

    mime.enable = true;
    mimeApps.enable = true;
  };

  # Desktop entries are stored at:
  #   - /run/current-system/sw/share/applications
  #   - /etc/profiles/per-user/$USER/share/applications
  home.activation.linkDesktopEntries = entryAfter [ "writeBoundary" "createXdgUserDirectories" ] ''
    if [ ! -d ${dataHome}/applications ]; then
      run mkdir -p ${dataHome}/applications
    fi

    run rm -f ${dataHome}/applications/*.desktop

    for file in /etc/profiles/per-user/elliott/share/applications/*.desktop; do
      link=${dataHome}/applications/$(basename "$file")
      run ln -s "$file" "$link"
    done
  '';
}
