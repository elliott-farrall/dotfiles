{ lib
, pkgs
, inputs
, system
, ...
}:

lib.pre-commit-hooks.${system}.run {
  src = ./.;

  excludes = [
    ".*\\.age$"
    ".*\\.hash$"
    ".*\\.ppd$"
    "^templates/[^/]+$"
    "^secrets.nix"
    ".*hardware\\.nix$"
    "^modules/nixos/boot/silent/boot/[^/]+$"
  ];

  hooks = {

    /* --------------------------------- Editor --------------------------------- */

    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    /* --------------------------------- Checks --------------------------------- */

    nil.enable = true;
    check-json.enable = true;
    check-toml.enable = true;
    check-yaml.enable = true;

    check-executables-have-shebangs.enable = true;
    check-shebang-scripts-are-executable.enable = true;

    /* --------------------------------- Format --------------------------------- */

    treefmt = {
      enable = true;
      package = inputs.self.formatter.${system};
    };

    /* ----------------------------------- Git ---------------------------------- */

    convco.enable = true;
    check-added-large-files = {
      enable = true;
      excludes = [ "\\wallpaper.jpg" ];
    };
    check-vcs-permalinks.enable = true;
    detect-private-keys.enable = true;
    forbid-new-submodules.enable = true;

    /* --------------------------------- Custom --------------------------------- */

    act = {
      enable = false; #TODO: Fix act pre-commit
      entry = "${lib.getExe pkgs.act} -nW";
      files = "^\\.github/workflows/.*\\.yaml$";
    };

    compose2nix = {
      enable = true;
      entry = "systems/*/*/**/compose.sh";
      files = "compose\\.yaml$";
      pass_filenames = false;
    };

    nix-auto-follow = {
      enable = true;
      entry = builtins.toString (pkgs.writeShellScript "nix-auto-follow" ''
        set -e
        ${lib.getExe inputs.nix-auto-follow.packages.${system}.default} -i
        nix flake lock
      '');
      files = "^flake\\.lock$";
      pass_filenames = false;
    };

  };
}
