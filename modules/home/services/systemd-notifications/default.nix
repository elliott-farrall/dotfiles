{ lib
, pkgs
, inputs
, config
, ...
}:

let
  cfg = config.services.systemd-notifications;
  inherit (cfg) enable;

  inherit (inputs.self.nixosConfigurations.runner.config.services.ntfy-sh) settings;
  ntfy-url = "${settings.base-url}${settings.listen-http}";
  ntfy-topic = "systemd";
in
{
  options = {
    services.systemd-notifications.enable = lib.mkEnableOption "notifications for systemd services" // { default = true; };
  };

  config = lib.mkIf enable {
    systemd.user.services."systemd-notifications-failure@" = {
      Unit = {
        Description = "Notify when a systemd service fails";
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "systemd-notifications-failure" ''
          ${pkgs.libnotify}/bin/notify-send 'Service Failed' "$1 has failed."

          ${lib.getExe pkgs.curl} \
            -H "Title: Service Failed" \
            -d "$1 has failed." \
          ${ntfy-url}/${ntfy-topic}
        ''} %i";
      };
    };

    xdg.configFile."systemd/user/service.d/systemd-notifications.conf".text = ''
      [Unit]
      OnFailure=systemd-notifications-failure@%n
    '';
  };
}
