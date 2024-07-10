{ lib
, pkgs
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    gptcommit.enable = true;

    editorconfig-checker.enable = true;

    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
  };
}
