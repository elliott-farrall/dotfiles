{ ...
}:

{
  age.secrets = {
    "rclone/DotFiles/url".file = ./url.age;
    "rclone/DotFiles/id".file = ./id.age;
    "rclone/DotFiles/key".file = ./key.age;
  };

  rclone.remotes.DotFiles = {
    type = "s3";
    provider = "Cloudflare";
    access_key_id = "rclone/DotFiles/id";
    secret_access_key = "rclone/DotFiles/key";
    endpoint = "rclone/DotFiles/url";
    path = "/dotfiles";
  };
}
