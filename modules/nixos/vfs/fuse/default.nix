{ lib
, format
, ...
}:

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    # Enables --allow-other in rclone mount
    programs.fuse.userAllowOther = true;
  };
}
