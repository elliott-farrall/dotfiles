{ ...
}:

{
  networking.usePredictableInterfaceNames = false;

  boot.initrd.services.udev.rules = ''
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="d4:5d:64:bb:79:75", KERNEL=="eth*", NAME="ont"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="d4:5d:64:bb:79:74", KERNEL=="eth*", NAME="lan"
  '';
}
