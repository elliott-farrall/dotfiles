{ lib
, ...
}:

{
  imports = [
    ../../x86_64-linux/sprout
  ];

  networking.hostName = lib.mkForce "sprout";

  virtualisation = {
    cores = 2;
    memorySize = 2 * 1024;
    diskSize = 10 * 1024;
  };
}
