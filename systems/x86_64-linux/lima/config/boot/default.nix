{ ...
}:

{
  imports = [
    ./efi.nix
  ];

  boot = {
    kernelParams = [
      "boot.shell_on_fail" # Allows for root shell if failure to boot. Requires root password.
    ];

    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = 3;
    };

    silent.enable = true;

    plymouth.enable = true;
    systemd.services."display-manager@" = {
      conflicts = [ "plymouth-quit.service" ];
      after = [
        "plymouth-quit.service"
        "rc-local.service"
        "plymouth-start.service"
        "systemd-user-sessions.service"
      ];
      onFailure = [ "plymouth-quit.service" ];

      serviceConfig = {
        ExecStartPost = [
          "-/usr/bin/sleep 30"
          "-/usr/bin/plymouth quit --retain-splash"
        ];
      };
    };
  };
}
