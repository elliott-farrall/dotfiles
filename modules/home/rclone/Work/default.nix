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
    "rclone/Work/id" = {
      file = ./id.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/Work/id";
    };
    "rclone/Work/token" = {
      file = ./token.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/Work/token";
    };
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
