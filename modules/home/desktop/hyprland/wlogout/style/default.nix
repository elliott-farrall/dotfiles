{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  inherit (config.lib.stylix) colors;
  inherit (config) catppuccin;

  accent = colors.${catppuccin.accentBase16};

  repo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "wlogout";
    rev = "main";
    hash = "sha256-QUSDx5M+BG7YqI4MBsOKFPxvZHQtCa8ibT0Ln4FPQ7I=";
  };
in
{
  config = lib.mkIf enable {
    programs.wlogout.style = /*css*/''
      @define-color accent #${accent};

      @define-color mantle ${colors.withHashtag.base01};
      @define-color surface0 ${colors.withHashtag.base02};
      @define-color text ${colors.withHashtag.base05};

      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(36, 39, 58, 0.90);
      }

      button {
        border-radius: 0;
        border-color: @accent;
        text-decoration-color: @text;
        color: @text;
        background-color: @mantle;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: @surface0;
        outline-style: none;
      }

      #lock {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/lock.svg");
      }

      #logout {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/logout.svg");
      }

      #suspend {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/suspend.svg");
      }

      #hibernate {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/hibernate.svg");
      }

      #shutdown {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/shutdown.svg");
      }

      #reboot {
        background-image: url("${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}/reboot.svg");
      }
    '';
  };
}
