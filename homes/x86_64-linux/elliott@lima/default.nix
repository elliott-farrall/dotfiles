{ pkgs
, config
, ...
}:

{

  /* --------------------------------- Desktop -------------------------------- */

  desktop = {
    hyprland.enable = true;
  };

  /* --------------------------------- Devices -------------------------------- */

  devices = {
    remarkable.enable = true;
  };

  /* -------------------------------- Packages -------------------------------- */

  terminal = "kitty";
  file-manager = "nemo";
  editor = "vscode-insiders";
  browser = "firefox";

  programs = {
    discord.enable = true;
    libreoffice.enable = true;
    mathematica.enable = true;
    minecraft.enable = true;
    obsidian.enable = true;
    zotero.enable = true;
  };

  home.packages = with pkgs; [
    act
    devbox
    devenv
    flox
    texlive.combined.scheme-full
  ];

  /* ----------------------------- Personalisation ---------------------------- */

  home.sessionVariables = {
    FLAKE = "${config.xdg.userDirs.extraConfig.XDG_REPO_DIR}/dotfiles";
  };

  gtk.gtk3.bookmarks = [
    "file://${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/OneDrive/Documents/University%20of%20Surrey/PG"
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1 silent] $VISUAL"
      "[workspace 2 silent] $BROWSER"
      "[workspace special:terminal silent] $TERMINAL"
    ];
  };

}
