{ lib
, system
, host
, ...
}:

{
  nixpkgs.hostPlatform = { inherit system; };

  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  garnix.server = {
    enable = true;
    persistence = {
      enable = true;
      name = host;
    };
  };
  age.identityPaths = [ "/var/garnix/keys/repo-key" ];
}
