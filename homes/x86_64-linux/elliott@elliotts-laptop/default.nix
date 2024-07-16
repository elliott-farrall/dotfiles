{ osConfig
, config
, ...
}:

{
  imports = [
    ./config
    ./scripts
  ];

  inherit (osConfig) catnerd;
  gtk.enable = true;
  qt.enable = true;

  inherit (osConfig) shell desktop locker;
  terminal = {
    default = "kitty";
    alacritty.enable = true;
    foot.enable = true;
    kitty.enable = true;
    wezterm.enable = true;
  };
  apps = {
    discord.enable = true;
    ldz.enable = true;
    libreoffice.enable = true;
    mathematica.enable = true;
    minecraft.enable = true;
    nemo.enable = true;
    obsidian.enable = true;
    vivaldi.enable = true;
    vscode.enable = true;
    zotero.enable = true;
  };
  tools = {
    nix.enable = true;
  };

  xdg.enable = true;
  programs.direnv = {
    enable = true;
    silent = true;
    config = {
      global.warn_timeout = 0;
    };
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "code -w";
    VISUAL = "code -w";
  };

  gtk.gtk3.bookmarks = [
    "file://${config.home.homeDirectory}/OneDrive/Documents/University%20of%20Surrey/PG"
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1 silent] code"
      "[workspace 2 silent] vivaldi"
    ];
  };
}
