{ ...
}:

{
  # boot.kernelParams = [ "ipv6.disable=1" ];

  networking = {
    useDHCP = false;

    interfaces."ont" = { };
    interfaces."lan" = {
      ipv4.addresses = [
        {
          address = "192.168.1.1";
          prefixLength = 24;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a01:4f8:1c1b:16d0::1";
          prefixLength = 64;
        }
      ];
    };
  };
}
