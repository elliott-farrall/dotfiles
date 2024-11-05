{ ...
}:

{
  imports = [
    ./config
  ];

  /* --------------------------------- Version -------------------------------- */

  version = {
    linux = "latest";
    nix = "latest";
    nixos = "24.11";
  };

  /* ---------------------------------- Theme --------------------------------- */

  programs.dconf.enable = true;

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

  /* --------------------------------- Locale --------------------------------- */

  locale = "uk";

  /* ---------------------------------- Shell --------------------------------- */

  shell = {
    default = "zsh";
    extraShells = [ ];
  };

  /* --------------------------------- Greeter -------------------------------- */

  greeter = "gtkgreet";

  /* --------------------------------- Locker --------------------------------- */

  locker = "gtklock";

  /* --------------------------------- Desktop -------------------------------- */

  desktop = {
    hyprwm.enable = true;
  };

  /* ---------------------------------- Tools --------------------------------- */

  tools = {
    android.enable = true;
  };

}
