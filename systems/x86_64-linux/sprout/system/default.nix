{ ...
}:

{
  networking.hostId = "2687f7ec";

  imports = [
    ./drives
    ./filesystem
    ./network
  ];

  facter.reportPath = ./hardware.json;
}
