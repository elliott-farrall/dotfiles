{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    editorconfig-checker.enable = true;

    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
  };
}
