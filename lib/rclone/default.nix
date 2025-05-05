{ ...
}:

{
  mkService = { pkgs, config, ... }:
    { name
    , mount ? config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR
    , path ? "/"
    }: {
      Unit = {
        Description = "Mount for ${name}";
        X-SwitchMethod = "stop-start";
      };
      Service = {
        Type = "notify";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mount}/${name}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount ${name}:${path} ${mount}/${name} --allow-other --file-perms 0777 --vfs-cache-mode writes";
        ExecStop = "/run/wrappers/bin/fusermount -u ${mount}/${name}";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
}
