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
    "rclone/OneDrive/id".file = ./id.age;
    "rclone/OneDrive/token".file = ./token.age;
  };

  programs.rclone.remotes.OneDrive = {
    config = {
      type = "onedrive";
      drive_type = "personal";
    };
    secrets = {
      drive_id = config.age.secrets."rclone/OneDrive/id".path;
      token = config.age.secrets."rclone/OneDrive/token".path;
    };
  };

  systemd.user.services.rclone-OneDrive = mkService { name = "OneDrive"; };
}
