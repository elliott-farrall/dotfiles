{ ...
}:

{
  age.secrets = {
    "rclone/Google/token".file = ./token.age;
  };

  rclone.remotes.Google = {
    type = "drive";
    token = "rclone/Google/token";
  };
}
