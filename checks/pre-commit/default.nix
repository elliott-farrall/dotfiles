{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    gptcommit = {
      enable = true;
      types = [ "nix" ];
    };

    editorconfig-checker = {
      enable = true;
      types_or = [ "nix" "shell" ];
    };

    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
  };
}
