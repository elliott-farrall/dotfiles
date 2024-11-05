{ lib
, ...
}:

{
  imports = [
    ../../x86_64-linux/broad
  ];

  networking.hostName = lib.mkForce "broad";
}
