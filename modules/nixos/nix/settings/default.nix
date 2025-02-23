{ lib
, ...
}:

{
  age.secrets."github/pat" = {
    file = ./pat.age;
    substitutions = [ "/etc/nix/nix.conf" ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
    access-tokens = "github.com=@github/pat@";

    accept-flake-config = true;
    substituters = lib.mkBefore [ "https://cache.garnix.io" ];
    trusted-public-keys = lib.mkBefore [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];

    use-xdg-base-directories = true;
    auto-optimise-store = true;
    min-free = "${toString (5 * 1024 * 1024 * 1024)}";
  };
}
