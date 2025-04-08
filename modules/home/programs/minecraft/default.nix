{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.minecraft;
  inherit (cfg) enable;

  icon = builtins.fetchurl {
    url = "https://dotfiles.beannet.io/icons/minecraft.png";
    sha256 = "sha256:0jwvbfvy52scgvz4s4gnfq79wc93kq2j4lrwgmgaz7ljm9ysy2y5";
  };

  package = pkgs.symlinkJoin {
    name = "minecraft";
    paths = [ pkgs.prismlauncher ];
    postBuild = ''
      install -v ${pkgs.prismlauncher}/share/applications/org.prismlauncher.PrismLauncher.desktop $out/share/applications/org.prismlauncher.PrismLauncher.desktop
      substituteInPlace $out/share/applications/org.prismlauncher.PrismLauncher.desktop \
        --replace "Name=Prism Launcher" "Name=Minecraft" \
        --replace "Icon=org.prismlauncher.PrismLauncher" "Icon=${icon}"
    '';
  };
in
{
  options = {
    programs.minecraft.enable = lib.mkEnableOption "Minecraft";
  };

  config = lib.mkIf enable {
    home.packages = [ package ];
  };
}
