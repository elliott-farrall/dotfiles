{ ...
}:

{
  age.secrets = {
    "rclone/Work/id".file = ./id.age;
    "rclone/Work/token".file = ./token.age;
  };

  rclone.remotes.Work = {
    type = "onedrive";
    token = "rclone/Work/token";
    drive_id = "rclone/Work/id";
    drive_type = "business";
  };
}
