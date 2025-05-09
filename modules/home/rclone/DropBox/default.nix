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
    "rclone/DropBox/token" = {
      file = ./token.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/DropBox/token";
    };
  };

  programs.rclone.remotes.DropBox = {
    config = {
      type = "dropbox";
    };
    secrets = {
      token = config.age.secrets."rclone/DropBox/token".path;
    };
  };

  systemd.user.services.rclone-DropBox = mkService { name = "DropBox"; };
}
