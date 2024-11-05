{ lib
, ...
}:

{
  users.users.deploy = {
    isSystemUser = true;
    group = "deploy";
    useDefaultShell = true;

    openssh.authorizedKeys.keys = [
      #TODO: New keys
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6ZP8YiM5PTp6ZrgVVdJq8UVifTK8IvEiKN5i1vTnMX"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1+DUQegdnmPTIPRG5ohsC5JrMpUqRf3iHh8xaZG5QvrTIZkSq1H6bUK3A7y7WH6z7SrF8Jp4ccQnGm3B3/xQrfZo5Lhiv25pp04TYtDI1MLcN6PaRVJOPMwqWE0M8jdDXyAatgurwi7uNx0JjElPxyRD3bFC6CLmrt5RLqFqHV3/0eYVro3N68+FvywBjn2f50wCMwyLNjmlD3xY2h2z4Tz4/L4r8DgGgTUMSVIODNuBt3y1eSghmxYdLf4Ms9/e+HLLrqfozSH7n5dYK+BVYjAE/b1OakwhgLorr6kyKb4fVLOZXw0Exa0RQED3USXraWY1/jn4EhrkcWQBCQCzSzgOmuO6qW8obJPEtYpH8p5zNnCLymLrxrqPBgTnSannPNTy/uxlHu4BqpdRTM5SoiRdlezKUhGkokV9acotO5kqFd1mVYjYhhdBnuEJfq2vnRoOrF5WqnQWBMwwQldbEdNggVFPExQLccMKpLv/hO/qe9J3jgB1CYYZJQuujZHQ5On/XynexmhWI3u27aXHcF2aA2XdNbCDeG/2WmTm2IXDHBFUbz1rjBxpFK8Ts0olt7scjKf5RFZwPjfdY3CcPVt8/keRXqGvM9zsNs0cfPPHCmYVwl+S0RQYhWSSDZxeK7GG5xDvcmfdTi9pT0Y/yL/UvYB4bA54kdzdfpzYfRQ=="
    ];

    extraGroups = [ "wheel" ];
  };

  users.groups.deploy = { };

  security.sudo.extraRules = lib.singleton {
    users = [ "deploy" ];
    commands = lib.singleton {
      command = "ALL";
      options = [ "NOPASSWD" ];
    };
  };
}
