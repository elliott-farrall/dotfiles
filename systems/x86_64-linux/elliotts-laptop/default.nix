{ config
, ...
}:

{
  imports = [
    ./config
    ./hardware-configuration.nix
  ];

  version = {
    linux = "latest";
    nix = "latest";
    nixos = "23.05";
  };

  home-manager = {
    useUserPackages = true;
    backupFileExtension = "old";
  };

  shell.default = "zsh";
  desktop.hyprwm.enable = true;
  locker.gtklock.enable = true;
  greeter.gtkgreet.enable = true;

  age.secrets = {
    password-elliott = {
      file = ./password-elliott.age;
    };
  };
  users.users = {
    elliott = {
      isNormalUser = true;
      uid = 1000;
      hashedPasswordFile = config.age.secrets.password-elliott.path;
      extraGroups = [ "networkmanager" "wheel" "docker" "openrazer" "adbusers" ];
    };
  };
}
