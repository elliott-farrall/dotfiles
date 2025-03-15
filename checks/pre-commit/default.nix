{ lib
, pkgs
, system
, inputs
, ...
}:

lib.pre-commit-hooks.${system}.run {
  src = ./.;

  excludes = (map lib.internal.globToRegex (import ../../formatters.nix).settings.global.excludes) ++ [
    ".*hardware\\.nix$"
    "^modules/nixos/boot/silent/boot/[^/]+$"
    "^secrets.nix"
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
      enable = false;
      entry = "${lib.getExe pkgs.act} -nW";
      files = "^\\.github/workflows/.*\\.yaml$";
    };

    follow-inputs = {
      enable = true;
      entry = builtins.toString (pkgs.writeShellScript "follow-inputs" ''
        set -e
        ${lib.getExe inputs.nix-auto-follow.packages.${system}.default} -i
        nix flake lock
      '');
      files = "^flake\\.lock$";
      pass_filenames = false;
    };

    prebuild = {
      enable = true;
      entry = "sh -c";
      files = "prebuild\\.sh$";
    };

  };
}
