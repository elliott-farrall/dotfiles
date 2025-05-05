{ lib
, namespace
, config
, ...
}@args:

let
  mkService = lib.${namespace}.mkService args;
in
{
  age.secrets = {
    "rclone/DotFiles/url".file = ./url.age;
    "rclone/DotFiles/id".file = ./id.age;
    "rclone/DotFiles/key".file = ./key.age;
  };

  programs.rclone.remotes.DotFiles = {
    config = {
      type = "s3";
      provider = "Cloudflare";
    };
    secrets = {
      access_key_id = config.age.secrets."rclone/DotFiles/id".path;
      secret_access_key = config.age.secrets."rclone/DotFiles/key".path;
      endpoint = config.age.secrets."rclone/DotFiles/url".path;
    };
  };

  systemd.user.services.rclone-DotFiles = mkService { name = "DotFiles"; path = "/dotfiles"; };
}
