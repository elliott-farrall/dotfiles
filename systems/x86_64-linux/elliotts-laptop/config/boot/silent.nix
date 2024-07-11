{ ...
}:

{
  boot = {
    # Hide stage 1 messages
    initrd.verbose = false;

    consoleLogLevel = 0;

    # Hide systemd-udevd messages
    kernelParams = [ "udev.log_level=3" ];
  };
}
