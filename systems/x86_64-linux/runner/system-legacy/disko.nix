{ ...
}:

{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=200M" ];
    };

    disk.main = {
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_54047850";
      content = {
        type = "gpt";
        partitions.boot = {
          type = "EF02";
          size = "1M";
        };
        partitions.ESP = {
          type = "EF00";
          size = "500M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        partitions.persistent = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/persistent";
          };
        };
      };
    };

    disk.volume = {
      device = "/dev/disk/by-id/scsi-0HC_Volume_101548136";
      content = {
        type = "gpt";
        partitions.nix = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
          };
        };
      };
    };
  };

  fileSystems."/persistent" = {
    neededForBoot = true;
  };

  age.identityPaths = [
    "/persistent/etc/ssh/ssh_host_ed25519_key"
    "/persistent/etc/ssh/ssh_host_rsa_key"
  ];

  nix.settings.build-dir = "/nix/tmp";
  systemd.tmpfiles.rules = [
    "d /nix/tmp 0755 root root -"
  ];
}
