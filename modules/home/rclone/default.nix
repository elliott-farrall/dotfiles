{ pkgs
, config
, ...
}:

#TODO - Use builtin rclone module

{
  rclone = {
    enable = true;
    path = "${config.home.homeDirectory}/Remotes";
  };

  home.packages = with pkgs; [
    rclone
  ];
}
