{ lib
, pkgs
, system
, ...
}:

lib.pre-commit-hooks.${system}.run {
  src = ./.;

  excludes = [
    ".*\\.age$"
    ".*\\.hash$"
    ".*\\.ppd$"
    "^modules/nixos/boot/silent/boot/[^/]+$"
  ];

  hooks = {

    /* --------------------------------- Editor --------------------------------- */

    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    typos = {
      enable = true;
      settings.configuration = /*toml*/ ''
        [default]
        extend-ignore-words-re = [ "AGS" ]
      '';
    };

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
      package = lib.treefmt-nix.mkWrapper pkgs ./treefmt.nix;
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

  };
}
