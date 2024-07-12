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
    hwRender = true;
    extraConfig = ''
      font-size=16
      font-dpi=255
      font-engine=pango
      xkb-model=pc105
      xkb-layout=us
      gpus=all
      render-engine=gltex
    '';
  };
  console = {
    font = "Lat2-Terminus16";
    # useXkbConfig = true; # use xkb.options in tty.
    earlySetup = true;
  };
}
