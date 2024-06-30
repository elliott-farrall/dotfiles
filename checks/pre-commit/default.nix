{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    gptcommit = {
      enable = true;
      types = [ "nix" "shell" ];
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
