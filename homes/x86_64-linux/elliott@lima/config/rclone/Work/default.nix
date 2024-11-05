{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    id-Work = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    token-Work = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [Work]
    type = onedrive
    token = @token-Work@
    drive_id = @id-Work@
    drive_type = business
  '';

  systemd.user.services.rclone-Work = mkService "Work" "/";
}
