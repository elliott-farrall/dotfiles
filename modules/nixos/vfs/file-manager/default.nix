{ lib
, pkgs
, format
, ...
}:

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    # Enable gvfs for trash and recents support in file managers
    services.gvfs.enable = true;

    # Issues with org.gtk.vfs.UDisks2VolumeMonitor, causes slow file-managers
    environment.sessionVariables.GVFS_REMOTE_VOLUME_MONITOR_IGNORE = "true";

    # Enable automated trash emptying
    services.cron = {
      enable = true;
      systemCronJobs = [ "@hourly ${pkgs.trash-cli}/bin/trash-empty --all-users -f 30" ];
    };
  };
}
