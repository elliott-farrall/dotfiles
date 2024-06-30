{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    gptcommit = {
      enable = true;
      excludes = [ "\\.age" ];
    };

    editorconfig-checker = {
      enable = false;
      excludes = [ "\\.age" ];
    };

    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
  };
}
