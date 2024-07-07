{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprwm;
  enable = cfg.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar = {
      enable = true;
      style = ''@import "${./style.css}";'';
      settings.mainBar = {
        mode = "dock";
        layer = "top";

        margin-top = 5;
        margin-left = 10;
        margin-right = 10;

        modules-left = [ "hyprland/workspaces" "custom/media" ];
        modules-center = [ "clock" ];
        modules-right = [ "group/system" "group/status" "group/menu" ];

        "group/menu" = {
          orientation = "inherit";
          modules = [
            "group/logout"
            "systemd-failed-units"
            "custom/notification"
          ];
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            "none" = "󰂜";
            "dnd-none" = "󰪑";
            "inhibited-none" = "󰪑";
            "dnd-inhibited-none" = "󰪑";

            "notification" = "󰂚";
            "dnd-notification" = "󰂛";
            "inhibited-notification" = "󰂛";
            "dnd-inhibited-notification" = "󰂛";
          };
          exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          return-type = "json";
          escape = true;
        };

        "systemd-failed-units" = {
          format = "󰒏 {nr_failed}";
          on-click = "${pkgs.kitty}/bin/kitty -e sh -c ' systemctl --user --failed; read -n 1'";
          on-click-right = "${pkgs.kitty}/bin/kitty -e sh -c ' systemctl --failed; read -n 1'";
        };

        "group/logout" = {
          orientation = "inherit";
          modules = [
            "custom/lock"
            "idle_inhibitor"
            "custom/power"
            "custom/reboot"
            "custom/logout"
          ];
          drawer = {
            "transition-left-to-right" = false;
          };
        };

        "custom/power" = {
          format = "󰐥";
          exec = ''
            printf '{"tooltip": "Shutdown"}'
          '';
          return-type = "json";
          on-click = "systemctl poweroff";
        };

        "custom/reboot" = {
          format = "󰜉";
          exec = ''
            printf '{"tooltip": "Reboot"}'
          '';
          return-type = "json";
          on-click = "systemctl reboot";
        };

        "custom/logout" = {
          format = "󰍃";
          exec = ''
            printf '{"tooltip": "Logout"}'
          '';
          return-type = "json";
          on-click = "loginctl terminate-session $XDG_SESSION_ID";
        };

        "custom/lock" = {
          format = "󰌾";
          exec = ''
            printf '{"tooltip": "Lock"}'
          '';
          return-type = "json";
          on-click = "loginctl lock-session";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            "activated" = "󰷛";
            "deactivated" = "󰍹";
          };
          tooltip-format-activated = "Idle Inhibitor (Activated)";
          tooltip-format-deactivated = "Idle Inhibitor (Deactivated)";
        };

        "group/status" = {
          orientation = "inherit";
          modules = [
            "backlight#status"
            "pulseaudio#status"
            "bluetooth#status"
            "network#status"
            "battery#status"
          ];
        };

        "battery#status" = {
          format = "{icon}";
          format-icons = {
            "default" = [ "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            "charging" = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            "plugged" = "󰚥";
          };
          states = {
            "warning" = 30;
            "critical" = 10;
          };
          tooltip-format-discharging = "Battery ({capacity}%)";
          tooltip-format-charging = "Charging ({capacity}%)";
          tooltip-format-not-charging = "Not Charging ({capacity}%)";
          tooltip-format-plugged = "Plugged In ({capacity}%)";
          on-click = "${config.programs.rofi.finalPackage}/bin/rofi -show power-menu -modi 'power-menu:rofi-power-menu --choices=lockscreen/logout/reboot/shutdown'";
        };

        "network#status" = {
          format = "{icon}";
          format-icons = {
            "default" = "󰤫";
            "disconnected" = "󰤮";
            "wifi" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            "ethernet" = "󰌗";
          };
          tooltip-format-disconnected = "Disconnected";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{essid} (Ethernet)";
          on-click = "${pkgs.internal.rofi-wifi-menu}/bin/rofi-wifi-menu";
        };

        "bluetooth#status" = {
          format = "{icon}";
          format-icons = {
            "disabled" = "󰀦";
            "connected" = "󰂰";
            "on" = "󰂯";
            "off" = "󰂲";
          };
          tooltip-format-disabled = "Bluetooth (Disabled)";
          tooltip-format-connected = "{device_alias} ({device_battery_percentage}%)";
          tooltip-format-on = "Bluetooth (On)";
          tooltip-format-off = "Bluetooth (Off)";
          on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
        };

        "pulseaudio#status" = {
          format = "{icon}";
          format-bluetooth = "{icon}<sup></sup>";
          format-muted = "󰝟";
          format-icons = {
            "default" = [ "󰕿" "󰖀" "󰕾" ];
            "headphone" = "󰋋";
            "hifi" = "󰓃";
            "hdmi" = "󰽟";
            "hands-free" = "󰋎";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "󰐺";
            "car" = "󰄋";
          };
          tooltip-format = "{desc} ({volume}%)";
          on-click = "${pkgs.internal.rofi-mixer}/bin/rofi-mixer";
        };

        "backlight#status" = {
          format = "{icon}";
          format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
          tooltip-format = "Brightness ({percent}%)";
          device = "intel_backlight";
        };

        "group/system" = {
          orientation = "inherit";
          modules = [
            "custom/button#system"
            "temperature#system"
            "cpu#system"
            "memory#system"
            "disk#system"
            "network#system"
          ];
          drawer = {
            "transition-left-to-right" = false;
          };
        };

        "custom/button#system" = {
          format = "󰄨";
          tooltip = false;
        };

        "temperature#system" = {
          thermal-zone = 1;
          format = "󰔏 {temperatureC}°C";
          tooltip-format = "Temperature ({temperatureC}°C)";
        };

        "cpu#system" = {
          format = "󰘚 {avg_frequency}GHz";
        };

        "memory#system" = {
          format = "󰍛 {used}GiB";
          tooltip-format = "RAM ({percentage}%)";
        };

        "disk#system" = {
          format = "󱛟 {used}";
          tooltip-format = "Disk ({percentage_used}%)";
        };

        "network#system" = {
          format = "󰛳 {bandwidthUpBits} | {bandwidthDownBits}";
          tooltip-format = "Network (Up: {bandwidthUpBytes} Down: {bandwidthDownBytes})";
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            format = {
              months = "<span font='UbuntuMono Nerd Font' color='#cad3f5'><b>{}</b></span>";
              weeks = "<span font='UbuntuMono Nerd Font' color='#cad3f5'>{}</span>";
              days = "<span font='UbuntuMono Nerd Font' color='#cad3f5'>{}</span>";
              weekdays = "<span font='UbuntuMono Nerd Font' color='#a5adcb'>{}</span>";
              today = "<span font='UbuntuMono Nerd Font' color='#f5bde6'><b>{}</b></span>";
            };
          };
          actions = {
            "on-click" = "shift_down";
            "on-click-right" = "shift_up";
          };
        };

        "custom/media" = {
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          exec = "${pkgs.writeShellScript "music_panel" ''
            # Inspired by:
            # https://github.com/Alexays/Waybar/discussions/2006

            CURRENT_SONG="${pkgs.writeShellScript "current_song" ''
              PLAYER_STATUS=$(${pkgs.playerctl}/bin/playerctl -s status | tail -n1)
              ARTIST=$(${pkgs.playerctl}/bin/playerctl metadata artist | sed 's/&/+/g')
              TITLE=$(${pkgs.playerctl}/bin/playerctl metadata title | sed 's/&/+/g')

              if [[ $PLAYER_STATUS == "Paused" || $PLAYER_STATUS == "Playing" ]]; then
                echo "$ARTIST - $TITLE"
              elif [[ $PLAYER_STATUS == "Stopped" ]]; then
                echo
              else
                exit 1
              fi
            ''}"

            ${pkgs.zscroll}/bin/zscroll \
              --delay 0.15 \
              --length 30 \
              --match-command "${pkgs.playerctl}/bin/playerctl status" \
              --scroll-padding " | " \
              --match-text "Playing" "--before-text '󰐊 ' --scroll 1" \
              --match-text "Paused" "--before-text '󰏤 ' --scroll 0" \
              --match-text "Stopped" "" \
              --update-interval 1 \
              --update-check true \
              $CURRENT_SONG
            wait
        ''}";
        };

        "hyprland/workspaces" = {
          format = "{icon} | {windows}";
          window-rewrite-default = "󰏗";
          window-rewrite = {
            "kitty" = "󰆍";
          };
        };
      };
    };
  };
}
