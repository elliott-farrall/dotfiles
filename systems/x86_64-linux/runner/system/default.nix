{ system
, host
, ...
}:

{
  nixpkgs.hostPlatform = { inherit system; };

  garnix.server = {
    enable = true;
    persistence = {
      enable = true;
      name = host;
    };
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  boot.loader.grub.device = "/dev/sda";

  age.identityPaths = [
    "/var/garnix/keys/repo-key"
  ];
}
