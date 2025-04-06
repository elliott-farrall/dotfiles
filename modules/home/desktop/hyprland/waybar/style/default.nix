{ lib
, config
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  inherit (config.lib.stylix) colors;
  inherit (config.stylix) fonts;

  accent = colors.${config.catppuccin.accentBase16};
in
{
  config = lib.mkIf enable {
    stylix.targets.waybar = {
      font = "sansSerif";
      addCss = false;
    };

    programs.waybar.style = /*css*/''
      @define-color accent #${accent};

      @define-color base @base00;
      @define-color surface0 @base02;
      @define-color surface1 @base03;
      @define-color surface2 @base04;
      @define-color text @base05;

      @define-color red @base08;
      @define-color peach @base09;
      @define-color yellow @base0A;
      @define-color green @base0B;
      @define-color teal @base0C;
      @define-color blue @base0D;
      @define-color mauve @base0E;

      #waybar {
        background: transparent;
      }

      tooltip {
        background: @surface0;
      }
      tooltip label {
        color: @text;
      }

      #menu,
      #status,
      #system,
      #clock,
      #custom-media,
      #workspaces {
        margin: 0;

        color: @accent;
        border-radius: 1rem;
        background-color: @surface0;
      }

      #custom-media {
        margin-left: 0.5rem;

        font-family: ${fonts.monospace.name};
      }

      #status,
      #system {
        margin-right: 0.5rem;
      }

      #custom-notification,
      #systemd-failed-units,
      #idle_inhibitor,
      #custom-logout,
      #battery.status,
      #network.status,
      #bluetooth.status,
      #pulseaudio.status,
      #backlight.status,
      #custom-button.system,
      #temperature.system,
      #cpu.system,
      #memory.system,
      #disk.system,
      #network.system,
      #clock,
      #custom-media,
      #workspaces button {
        padding: 0 0.5rem;
        border-radius: 1rem;
      }
      #custom-notification:hover,
      #systemd-failed-units:hover,
      #idle_inhibitor:hover,
      #custom-logout:hover,
      #battery.status:hover,
      #network.status:hover,
      #bluetooth.status:hover,
      #pulseaudio.status:hover,
      #custom-button.system:hover,
      #workspaces button:hover {
        background-color: @surface1;
      }

      #custom-notification {
        color: @accent;
      }

      #battery.status {
        color: @green;
      }
      #battery.status.charging {
        color: @green;
      }
      #battery.status.warning:not(.charging) {
        color: @yellow;
      }
      #battery.status.critical:not(.charging) {
        color: @red;
      }

      #network.status {
        margin-right: 0.5rem;

        color: @teal;
      }

      #bluetooth.status {
        margin-right: 0.5rem;

        color: @blue;
      }

      #pulseaudio.status {
        margin-right: 0.5rem;

        color: @red;
      }

      #backlight.status {
        margin-right: 0.5rem;

        color: @yellow;
      }

      #custom-button.system {
        color: @accent;
      }

      #temperature.system {
        margin-right: 0.5rem;

        color: @red;
      }

      #cpu.system {
        margin-right: 0.5rem;

        color: @teal;
      }

      #memory.system {
        margin-right: 0.5rem;

        color: @mauve;
      }

      #disk.system {
        margin-right: 0.5rem;

        color: @green;
      }

      #network.system {
        margin-right: 0.5rem;

        color: @peach;
      }

      #workspaces button {
        color: @text;
      }
      #workspaces button.empty {
        color: @surface2;
      }
      #workspaces button.active {
        color: @accent;
      }
    '';
  };
}
