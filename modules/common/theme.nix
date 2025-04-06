{ lib
, pkgs
, ...
}:

let
  flavour = "macchiato";
  accent = "mauve";

  inherit (lib.internal) capitalise;
in
{
  options.catppuccin = {
    flavour = lib.mkOption {
      default = "mocha";
      type = lib.types.enum [ "frappe" "latte" "macchiato" "mocha" ];
    };
    accentBase16 = lib.mkOption {
      default = "blue";
      type = lib.types.enum [ "red" "orange" "yellow" "green" "cyan" "blue" "magenta" "brown" ];
    };
  };

  config = {
    catppuccin = {
      inherit flavour accent;
      flavor = flavour;
      accentBase16 = {
        red = "red";
        peach = "orange";
        yellow = "yellow";
        green = "green";
        teal = "cyan";
        blue = "blue";
        mauve = "magenta";
        flamingo = "brown";
      }.${accent};
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${flavour}.yaml";
      image = ./wallpaper.jpg;

      fonts = {
        serif = {
          name = "Ubuntu Nerd Font";
          package = pkgs.nerd-fonts.ubuntu;
        };
        sansSerif = {
          name = "Ubuntu Nerd Font";
          package = pkgs.nerd-fonts.ubuntu;
        };
        monospace = {
          name = "UbuntuMono Nerd Font";
          package = pkgs.nerd-fonts.ubuntu-mono;
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        sizes = {
          applications = 10;
          desktop = 10;
          popups = 10;
          terminal = 11;
        };
      };

      cursor = {
        name = "catppuccin-${flavour}-${accent}-cursors";
        package = pkgs.catppuccin-cursors."${flavour}${capitalise accent}";
        size = 24;
      };
    };
  };
}
