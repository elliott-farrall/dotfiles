{ pkgs
, ...
}:

{
  imports = [
    ./gtklock
    ./hyprland
    ./hyprpaper
    ./kitty
    ./waybar
    ./rofi
    ./swaync
  ];

  gtk.enable = true;
  qt.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;

    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ hyprland ];
    };

    desktopEntries = {
      "cups" = {
        name = "Manage Printing";
        comment = "CUPS Web Interface";
        icon = "cups";
        noDisplay = true;

        exec = "xdg-open http://localhost:631";
        type = "Application";
        terminal = false;
        startupNotify = false;

        categories = [ "System" "Printing" "HardwareSettings" "X-Red-Hat-Base" ];
      };
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "hyprwm" ''
      ${pkgs.hyprland}/bin/Hyprland > /dev/null 2>&1
    '')
  ];
}
