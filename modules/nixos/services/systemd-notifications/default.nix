{ lib
, pkgs
, inputs
, format
, config
, ...
}:

let
  cfg = config.services.systemd-notifications;
  inherit (cfg) enable;

  inherit (inputs.self.nixosConfigurations.runner.config.services.ntfy-sh) settings;
  ntfy-url = "${settings.base-url}${settings.listen-http}";
  ntfy-topic = "systemd";

  conf-pkg = pkgs.runCommandNoCC "systemd-notifications.conf"
    {
      preferLocalBuild = true;
      allowSubstitutes = false;
    } ''
    mkdir -p $out/etc/systemd/system/service.d/
    echo "[Unit]" > $out/etc/systemd/system/service.d/systemd-notifications.conf
    echo "OnFailure=systemd-notifications-failure@%n" >> $out/etc/systemd/system/service.d/systemd-notifications.conf
  '';
in
{
  options = {
    services.systemd-notifications.enable = lib.mkEnableOption "notifications for systemd services" // { default = format == "linux"; };
  };

  config = lib.mkIf enable {
    systemd.services."systemd-notifications-failure@" = {
      description = "Notify when a systemd service fails";

      path = with pkgs; [
        libnotify
        getent
        gawk
        sudo
        dbus
      ];

      script = ''
        ${lib.getExe pkgs.curl} \
          -H "Title: Service Failed" \
          -d "$1 has failed." \
        ${ntfy-url}/${ntfy-topic}
      '';
      scriptArgs = "%i";
    };

    systemd.packages = [ conf-pkg ];
  };
}
