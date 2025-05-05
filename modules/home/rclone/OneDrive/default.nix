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
    "rclone/OneDrive/id" = {
      file = ./id.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/OneDrive/id";
    };
    "rclone/OneDrive/token" = {
      file = ./token.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/OneDrive/token";
    };
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
