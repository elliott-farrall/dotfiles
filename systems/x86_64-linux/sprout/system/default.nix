{ ...
}:

{
  fileSystems."/".device = "/dev/sda1";
  boot.loader.grub.device = "nodev";
}
