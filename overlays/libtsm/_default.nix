{ sources ? import ../nix/sources.nix
, pkgs
, ...
}:

final: prev:
{
  libtsm = prev.libtsm.overrideAttrs (attrs: rec {
    version = "unstable-2023-12-24";

    src = pkgs.fetchFromGitHub { inherit (sources.libtsm) owner repo rev sha256; };
  });
}
