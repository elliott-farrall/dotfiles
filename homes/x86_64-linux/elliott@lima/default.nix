{ osConfig
, config
, lib
, pkgs
, ...
}:

{
  imports = [
    ./config
  ];

  xdg.enable = true;

  /* ---------------------------------- Theme --------------------------------- */

  catnerd = lib.optionalAttrs (osConfig != null) osConfig.catnerd;
  gtk.enable = true;
  qt.enable = true;

  /* ---------------------------------- Shell --------------------------------- */

  shell = lib.optionalAttrs (osConfig != null) osConfig.shell;

  /* --------------------------------- Desktop -------------------------------- */

  desktop = lib.optionalAttrs (osConfig != null) osConfig.desktop;

  /* -------------------------------- Packages -------------------------------- */

  terminal = {
    default = "kitty";
    alacritty.enable = true;
    foot.enable = true;
    kitty.enable = true;
  };

  tools = {
    direnv.enable = true;
    nix.enable = true;
  };

  apps = {
    discord.enable = true;
    ldz.enable = true;
    libreoffice.enable = true;
    mathematica.enable = true;
    minecraft.enable = true;
    nemo.enable = true;
    obsidian.enable = true;
    remarkable.enable = true;
    vivaldi.enable = true;
    vscode.enable = true;
    zotero.enable = true;
  };

  home.packages = with pkgs; [
    internal.window-status
  ];

  /* -------------------------------- Services -------------------------------- */

  services = {
    test.enable = true;
    systemd-notifications.enable = true;
  };

  /* ----------------------------- Personalisation ---------------------------- */

  home.sessionVariables = {
    FLAKE = "${config.xdg.userDirs.extraConfig.XDG_REPO_DIR}/dotfiles";
    EDITOR = "code -w";
    VISUAL = "code -w";
  };

  gtk.gtk3.bookmarks = [
    "file://${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/OneDrive/Documents/University%20of%20Surrey/PG"
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1 silent] code"
      "[workspace 2 silent] vivaldi"
    ];
  };
}
