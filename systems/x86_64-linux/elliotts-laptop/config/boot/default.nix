{ lib
, ...
}:

{
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth.enable = true;

    kernelParams = [
      "boot.shell_on_fail"
      "i915.fastboot=1"

      "splash"
      "bgrt_disable"

      "quiet"
      "loglevel=3"
      "udev.log_level=3"
      "udev.log_priority=3"
      "systemd.show_status=false"
    ];

    loader = {
      timeout = lib.mkDefault 3;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        gfxmodeEfi = "2256x1504";
      };
    };
  };
}
