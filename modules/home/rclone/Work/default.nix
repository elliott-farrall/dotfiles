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
    "rclone/Work/id".file = ./id.age;
    "rclone/Work/token".file = ./token.age;
  };

  programs.rclone.remotes.Work = {
    config = {
      type = "onedrive";
      drive_type = "business";
    };
    secrets = {
      drive_id = config.age.secrets."rclone/Work/id".path;
      token = config.age.secrets."rclone/Work/token".path;
    };
  };

  systemd.user.services.rclone-Work = mkService { name = "Work"; };
}
