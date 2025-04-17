{ lib
, ...
}:

{
  imports = [
    ./config
  ];

  options.network = {
    lan-ip = lib.mkOption {
      type = lib.types.str;
      default = "192.168.10.1";
      description = "The IP address of the local network.";
    };
    dhcp-ip.min = lib.mkOption {
      type = lib.types.str;
      default = "192.168.10.50";
      description = "The minimum IP address for the DHCP range.";
    };
    dhcp-ip.max = lib.mkOption {
      type = lib.types.str;
      default = "192.168.10.254";
      description = "The maximum IP address for the DHCP range.";
    };
  };
}
