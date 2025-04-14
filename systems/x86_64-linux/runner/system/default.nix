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
  age.identityPaths = [ "/var/garnix/keys/repo-key" ];
}
