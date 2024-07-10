{ ...
}:

{
  imports = [
    ./config
    ./users

    ./hardware-configuration.nix
  ];

  version = {
    nix = "latest";
    nixos = "23.05";
  };

  home-manager = {
    useUserPackages = true;
    backupFileExtension = "old";
  };

  shell.zsh.enable = true;
  desktop.hyprwm.enable = true;
  locker.gtklock.enable = true;
  greeter.gtkgreet.enable = true;

  catnerd = {
    enable = true;

    flavour = "macchiato";
    accent = "pink";

    cursor.size = 24;

    fonts.main = {
      family = "Ubuntu";
      size = 10;
    };
    fonts.mono = {
      family = "DroidSansM";
      size = 14;
    };
  };
}
