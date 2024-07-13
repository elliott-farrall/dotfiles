{ config
, ...
}:

{
  age.secrets = {
    password-elliott = {
      file = ./password.age;
    };
  };

  users.users.elliott = {
    isNormalUser = true;
    uid = 1000;
    hashedPasswordFile = config.age.secrets.password-elliott.path;
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "openrazer" "adbusers" ];
  };
}
