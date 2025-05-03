{ ...
}:

let
  drive-id = "nvme-INTEL_SSDPEDME400G4_CVMD43820041400AGN";
in
{
  disko.devices = {
    disk."main" = {
      device = "/dev/disk/by-id/${drive-id}";

      content = {
        type = "gpt";

        partitions."boot" = {
          type = "EF02";
          size = "1M";
        };
        partitions."efi" = {
          type = "EF00";
          size = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        partitions."nixos" = {
          size = "100%";
          content = {
            type = "zfs";
            pool = "nixos";
          };
        };
      };
    };

    zpool."nixos" = {
      rootFsOptions.mountpoint = "none";

      datasets."root" = {
        type = "zfs_fs";
        mountpoint = "/";
        postCreateHook = "zfs snapshot nixos/root@blank";
      };
      datasets."nix" = {
        type = "zfs_fs";
        mountpoint = "/nix";
      };
      datasets."persist" = {
        type = "zfs_fs";
        mountpoint = "/persist";
      };
    };
  };
}
