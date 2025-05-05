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
    "rclone/Google/token" = {
      file = ./token.age;
      path = "${config.home.homeDirectory}/.config/rclone/secrets/Google/token";
    };
  };

  programs.rclone.remotes.Google = {
    config = {
      type = "drive";
    };
    secrets = {
      token = config.age.secrets."rclone/Google/token".path;
    };
  };

  systemd.user.services.rclone-Google = mkService { name = "Google"; };
}
