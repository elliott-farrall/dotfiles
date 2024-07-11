{ ...
}:

{
  boot = {
    # Hide stage 1 messages
    initrd.verbose = false;

    # Hide initrd and systemd-udevd messages
    kernelParams = [ "splash" "udev.log_level=3" ];
  };
}
