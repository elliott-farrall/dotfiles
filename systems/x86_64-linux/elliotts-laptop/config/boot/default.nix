{ lib
, ...
}:

{
  imports = [
    ./efi.nix
    ./silent.nix
  ];

  boot = {
    kernelParams = [
      "boot.shell_on_fail" # Allows for root shell if failure to boot. Requires root password.
      "i915.fastboot=1"
    ];

    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = lib.mkDefault 3;
    };

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
  };
}
