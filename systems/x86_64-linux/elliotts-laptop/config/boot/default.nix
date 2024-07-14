{ lib
, pkgs
, ...
}:

{
  imports = [
    ./efi.nix
    ./silent.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # blacklistedKernelModules = [
    #   "i915"
    #   "xe"
    # ];

    kernelParams = [
      "boot.shell_on_fail" # Allows for root shell if failure to boot. Requires root password.
      # "i915.modeset=0"
    ];

    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      timeout = lib.mkDefault 3;
    };

    plymouth.enable = true;
  };

  services.kmscon = {
    enable = true;
  };
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    # videoDrivers = lib.mkForce [ "modesetting" ];

    # moduleSection = ''
    #   Load "modesetting"
    # '';
    # deviceSection = ''
    #   Identifier "Intel Graphics"
    #   Driver "modesetting"
    # '';
  };
}
