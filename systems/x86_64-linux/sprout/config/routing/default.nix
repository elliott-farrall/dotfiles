{ lib
, ...
}:

{
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = lib.mkForce true; #FIXME: NAT should set this

  networking = {
    firewall.enable = true;

    nat = {
      enable = true;

      internalInterfaces = [ "lan" ];
      externalInterface = "wan";
    };
  };
}
