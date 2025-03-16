{ pkgs
, config
, ...
}:

{
  rclone = {
    enable = true;
    path = "${config.home.homeDirectory}/Remotes";
  };

  home.packages = with pkgs; [
    rclone
  ];
}
