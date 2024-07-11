{ lib
, ...
}:

{
  imports = [
    ./efi.nix
    ./silent.nix
  ];

  boot = {
    # consoleLogLevel = 0;
    # initrd.verbose = false;

    plymouth.enable = true;
    # systemd.services.greetd = {
    #   overrideStrategy = "asDropin";
    #   unitConfig = {
    #     Conflicts = [ "plymouth-quit.service" ];
    #     After = [ "plymouth-quit.service" "rc-local.service" "plymouth-start.service" "systemd-user-sessions.service" ];
    #     OnFailure = [ "plymouth-quit.service" ];
    #   };
    #   serviceConfig = {
    #     ExecStartPost = [ "-${pkgs.coreutils}/bin/sleep 30" "-${pkgs.plymouth}/bin/plymouth quit --retain-splash" ];
    #   };
    # };

    kernelParams = [
      "boot.shell_on_fail" # Allows for root shell if failure to boot. Requires root password.
      # "i915.fastboot=1"

      # "splash" # Enable splash screen
      # "bgrt_disable" # Do not display the OEM logo after loading the ACPI tables

      # "quiet" # Disable kernel messages
      # "loglevel=3"
      # "udev.log_level=3"
      # "udev.log_priority=3"
      # "systemd.show_status=false"
    ];

    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = lib.mkDefault 3;
    };
  };
}
