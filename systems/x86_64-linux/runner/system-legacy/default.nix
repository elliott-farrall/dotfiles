{ system
, ...
}:

{
  imports = [
    ./disko.nix
  ];

  nixpkgs.hostPlatform = { inherit system; };

  facter.reportPath = ./hardware.json;
}
