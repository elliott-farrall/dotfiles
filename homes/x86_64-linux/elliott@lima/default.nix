{ config
, ...
}:

{

  /* --------------------------------- Desktop -------------------------------- */

  desktop = {
    hyprland.enable = true;
  };

  /* -------------------------------- Packages -------------------------------- */

  terminal = "kitty";
  file-manager = "nemo";
  editor = "vscode";
  browser = "firefox";

  programs = {
    discord.enable = true;
    libreoffice.enable = true;
    mathematica.enable = false;
    minecraft.enable = true;
    obsidian.enable = true;
    zotero.enable = true;
  };

  /* ----------------------------- Personalisation ---------------------------- */

  home.sessionVariables = {
    NH_FLAKE = "${config.xdg.userDirs.extraConfig.XDG_REPO_DIR}/dotfiles";
  };

  gtk.gtk3.bookmarks = [
    "file://${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/OneDrive/Documents/University%20of%20Surrey/PG"
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1 silent] ${config.home.sessionVariables.VISUAL or null}"
      "[workspace 2 silent] ${config.home.sessionVariables.BROWSER or null}"
      "[workspace special:terminal silent] ${config.home.sessionVariables.TERMINAL or null}"
    ];
  };

}
