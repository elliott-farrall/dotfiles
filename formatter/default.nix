{ pkgs
, inputs
, ...
}:

inputs.treefmt-nix.lib.mkWrapper pkgs ../checks/pre-commit/treefmt.nix
