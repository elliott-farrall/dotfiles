{ lib
, system
, host
, ...
}:

{
  nixpkgs.hostPlatform = { inherit system; };

  # fileSystems."/" = {
  #   device = "/dev/sda1";
  #   fsType = "ext4";
  # };
  # boot.loader.grub.device = "/dev/sda";

  garnix.server = {
    enable = true;
    persistence = {
      enable = true;
      name = host;
    };
  };
  age.identityPaths = [ "/var/garnix/keys/repo-key" ];

  services.comin.enable = lib.mkForce false;
}
