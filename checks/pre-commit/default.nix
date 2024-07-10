{ lib
, ...
}:

lib.pre-commit-hooks.x86_64-linux.run {
  src = ./.;

  hooks = {
    gptcommit.enable = true;
    forbid-new-submodules.enable = true;
    no-commit-to-branch.settings.branch = [ "main" ];

    check-added-large-files.enable = true;
    check-executables-have-shebangs.enable = true;
    check-shebang-scripts-are-executable.enable = true;
    detect-private-keys.enable = true;
    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    hunspell.enable = true;
    typos.enable = true;

    nil.enable = true;
    nixpkgs-fmt.enable = true;
    deadnix.enable = false;
    statix.enable = false;

    beautysh.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
  };
}
