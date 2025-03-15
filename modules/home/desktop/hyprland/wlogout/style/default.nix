{ lib
, pkgs
, config
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
  icons = "${repo}/icons/wlogout/${catppuccin.flavour}/${catppuccin.accent}";
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
        background-image: url("${icons}/lock.svg");
      }

      #logout {
        background-image: url("${icons}/logout.svg");
      }

      #suspend {
        background-image: url("${icons}/suspend.svg");
      }

      #hibernate {
        background-image: url("${icons}/hibernate.svg");
      }

      #shutdown {
        background-image: url("${icons}/shutdown.svg");
      }

      #reboot {
        background-image: url("${icons}/reboot.svg");
      }
    '';
  };
}
