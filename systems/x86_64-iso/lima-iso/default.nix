{ lib
, ...
}:

{
  imports = [
    ../../x86_64-linux/lima
  ];

  networking.hostName = lib.mkForce "lima";
}
