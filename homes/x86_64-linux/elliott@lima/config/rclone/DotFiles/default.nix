{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    url-DotFiles = {
      file = ./url.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    id-DotFiles = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    key-DotFiles = {
      file = ./key.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [DotFiles]
    type = s3
    provider = Cloudflare
    access_key_id = @id-DotFiles@
    secret_access_key = @key-DotFiles@
    endpoint = @url-DotFiles@
    acl = private
  '';

  systemd.user.services.rclone-DotFiles = mkService "DotFiles" "/dotfiles";
}
