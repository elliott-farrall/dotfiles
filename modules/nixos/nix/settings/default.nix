{ lib
, ...
}:

let
  toBytesString = gb: toString (gb * 1024 * 1024 * 1024);
in
{
  age.secrets."github/pat" = {
    file = ./pat.age;
    substitutions = [ "/etc/nix/nix.conf" ];
  };

  documentation.nixos.enable = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
    access-tokens = "github.com=@github/pat@";

    accept-flake-config = true;
    substituters = lib.mkBefore [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://cache.flox.dev"
    ];
    trusted-public-keys = lib.mkBefore [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];

    use-xdg-base-directories = true;
    auto-optimise-store = true;
    min-free = toBytesString 2;
  };
}
