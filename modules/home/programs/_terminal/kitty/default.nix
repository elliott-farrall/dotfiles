{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "kitty";

  package = pkgs.symlinkJoin {
    name = "kitty";
    paths = [ pkgs.kitty ];
    postBuild = ''
      install -v ${pkgs.kitty}/share/applications/kitty.desktop $out/share/applications/kitty.desktop
      substituteInPlace $out/share/applications/kitty.desktop \
        --replace "Name=kitty" "Name=Kitty"
    '';
  };
in
{
  config = lib.mkIf enable {
    programs.kitty = {
      enable = true;
      inherit package;
      settings.confirm_os_window_close = 0;
    };
  };
}
