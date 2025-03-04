{ system
, ...
}:

{
  nixpkgs.hostPlatform = { inherit system; };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  boot.loader.grub.device = "/dev/sda";

  age.identityPaths = [
    "/var/garnix/keys/repo-key"
  ];
}
