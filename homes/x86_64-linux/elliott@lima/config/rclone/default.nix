{ config
, pkgs
, ...
}:

let
  mkService = remote: path: {
    Unit = {
      Description = "Mount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      ExecStart = "${pkgs.rclone}/bin/rclone mount ${remote}:${path} ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote} --allow-other --file-perms 0777 --vfs-cache-mode writes";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Unmount not working for FUSE without sudo
  # mkMount = remote: {
  #   Unit = {
  #     Description = "Mount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     After = [ "network-online.target" ];
  #   };
  #   Mount = {
  #     Type = "fuse.rclonefs";
  #     What = "${remote}:";
  #     Where = "${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     Options = lib.concatStringsSep "," [ "allow_other" "file_perms=0777" "vfs-cache-mode=writes" ];
  #     ExecSearchPath = "${pkgs.rclone}/bin/:/run/wrappers/bin/";
  #   };
  #   Install = {
  #     # Since we are not using automount
  #     WantedBy = [ "default.target" ];
  #   };
  # };

  # Automount units not working as user units
  # mkAutoMount = remote: {
  #   Unit = {
  #     Description = "Automount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     After = [ "network-online.target" ];
  #     Before = [ "remote-fs.target" ];
  #   };
  #   Automount = {
  #     Where = "${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     TimeoutIdleSec = 600;
  #   };
  #   Install = {
  #     WantedBy = [ "multi-user.target" ];
  #   };
  # };
in
{
  imports = [
    (import ./DotFiles { inherit mkService; })
    (import ./DropBox { inherit mkService; })
    (import ./Google { inherit mkService; })
    (import ./OneDrive { inherit mkService; })
    (import ./Work { inherit mkService; })
  ];

  home.packages = with pkgs; [
    rclone
  ];

  xdg.configFile."rclone/rclone.conf".force = true;
}
