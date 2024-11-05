{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    token-DropBox = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [DropBox]
    type = dropbox
    token = @token-DropBox@
  '';

  systemd.user.services.rclone-DropBox = mkService "DropBox" "/";
}
