{ config
, osConfig
, ...
}:

{
  imports = [
    ./apps
    ./config
    ./tools
  ];

  inherit (osConfig) catnerd;

  inherit (osConfig) shell desktop locker;

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
