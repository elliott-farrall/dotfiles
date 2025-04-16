{ ...
}:

{
  imports = [
    ./efi.nix
  ];

  #TODO - Clean lima boot config

  boot = {
    kernelParams = [
      "boot.shell_on_fail" # Allows for root shell if failure to boot. Requires root password.
    ];

    # initrd.kernelModules = [ "i915" ]; # Early KMS

    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = 3;
    };

    # systemd.services."display-manager@" = {
    #   conflicts = [ "plymouth-quit.service" ];
    #   after = [
    #     "plymouth-quit.service"
    #     "rc-local.service"
    #     "plymouth-start.service"
    #     "systemd-user-sessions.service"
    #   ];
    #   onFailure = [ "plymouth-quit.service" ];

    #   serviceConfig = {
    #     ExecStartPost = [
    #       "-/usr/bin/sleep 30"
    #       "-/usr/bin/plymouth quit --retain-splash"
    #     ];
    #   };
    # };
  };
}
