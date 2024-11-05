{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    token-Google = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [Google]
    type = drive
    token = @token-Google@
    team_drive =
  '';

  systemd.user.services.rclone-Google = mkService "Google" "/";
}
