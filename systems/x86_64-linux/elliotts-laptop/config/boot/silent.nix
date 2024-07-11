{ ...
}:

{
  boot = {
    # consoleLogLevel = 0;

    # Disable stage 1 messages
    initrd.verbose = false;

    kernelParams = [ "udev.log_level=3" ];
  };
}
