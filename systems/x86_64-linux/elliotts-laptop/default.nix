{ ...
}:

{
  imports = [
    ./config
    ./desktop
    ./users

    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.05";

  home-manager = {
    useUserPackages = true;
    backupFileExtension = "old";
  };

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
