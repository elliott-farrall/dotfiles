{ lib
, pkgs
, ...
}:

{
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth.enable = true;
    systemd.services.greetd = {
      overrideStrategy = "asDropin";
      unitConfig = {
        Conflicts = [ "plymouth-quit.service" ];
        After = [ "plymouth-quit.service" "rc-local.service" "plymouth-start.service" "systemd-user-sessions.service" ];
        OnFailure = [ "plymouth-quit.service" ];
      };
      serviceConfig = {
        ExecStartPost = [ "-${pkgs.coreutils}/bin/sleep 30" "-${pkgs.plymouth}/bin/plymouth quit --retain-splash" ];
      };
    };

    kernelParams = [
      "boot.shell_on_fail"
      "i915.fastboot=1"

      "splash"
      "bgrt_disable"

      # "quiet"
      # "loglevel=3"
      # "udev.log_level=3"
      # "udev.log_priority=3"
      "systemd.show_status=false"
    ];

    loader = {
      timeout = lib.mkDefault 3;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };
  };
}
