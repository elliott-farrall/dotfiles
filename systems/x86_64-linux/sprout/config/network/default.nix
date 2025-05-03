{ ...
}:

{
  boot.kernelParams = [ "ipv6.disable=1" ];

  networking = {
    useDHCP = false;

    interfaces."ont" = { };
    interfaces."lan" = {
      ipv4.addresses = [
        {
          address = "10.0.0.1";
          prefixLength = 24;
        }
      ];
    };
  };
}
