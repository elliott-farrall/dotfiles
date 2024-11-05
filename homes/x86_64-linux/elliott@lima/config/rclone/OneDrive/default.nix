{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    id-OneDrive = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    token-OneDrive = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [OneDrive]
    type = onedrive
    token = @token-OneDrive@
    drive_id = @id-OneDrive@
    drive_type = personal
  '';

  systemd.user.services.rclone-OneDrive = mkService "OneDrive" "/";
}
