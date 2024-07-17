{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    # Git
    gptcommit.enable = true;
    forbid-new-submodules.enable = true;
    no-commit-to-branch.settings.branch = [ "main" ];
    # Misc
    check-added-large-files.enable = true;
    check-executables-have-shebangs.enable = true;
    check-shebang-scripts-are-executable.enable = true;
    detect-private-keys.enable = true;
    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;
    # Nix
    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
    statix.enable = true;
    # Shell
    beautysh.enable = false; # Conflicts with shfmt
    shellcheck.enable = false; # Has issues with nix-shell shebangs
    shfmt.enable = true;
    # TOML
    check-toml.enable = true;
    taplo.enable = true;
  };
}
