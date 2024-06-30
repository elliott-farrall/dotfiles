{ lib
, ...
}:

{
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth.enable = true;

    kernelParams = [
      "quiet"
      "splash"
      "bgrt_disable"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
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
