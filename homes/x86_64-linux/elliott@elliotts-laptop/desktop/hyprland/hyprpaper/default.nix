{ pkgs
, ...
}:

{
  home.packages = with pkgs; [ hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    splash = false

    preload = ${./wallpaper.jpg}
    wallpaper = ,${./wallpaper.jpg}
  '';
}
