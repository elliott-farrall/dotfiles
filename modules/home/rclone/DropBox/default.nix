{ ...
}:

{
  age.secrets = {
    "rclone/DropBox/token".file = ./token.age;
  };

  rclone.remotes.DropBox = {
    type = "dropbox";
    token = "rclone/DropBox/token";
  };
}
