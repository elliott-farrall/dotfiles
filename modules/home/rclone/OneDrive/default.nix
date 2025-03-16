{ ...
}:

{
  age.secrets = {
    "rclone/OneDrive/id".file = ./id.age;
    "rclone/OneDrive/token".file = ./token.age;
  };

  rclone.remotes.OneDrive = {
    type = "onedrive";
    token = "rclone/OneDrive/token";
    drive_id = "rclone/OneDrive/id";
    drive_type = "personal";
  };
}
