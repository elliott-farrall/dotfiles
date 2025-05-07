{ lib
, pkgs
, ...
}:

lib.treefmt-nix.mkWrapper pkgs {
  projectRootFile = ".git/config";

  settings.global.excludes = [
    "LICENSE.md"
    "README.md"
    ".editorconfig"
    "*.env"
    "*.ini"
    "*.conf"
    "*.age"
    "*.hash"
    "*.ppd"
    "*.jpg"
    "templates/**"
    "**/hardware.nix"
  ];

  programs = {
    prettier.enable = true;

    # Nix
    nixpkgs-fmt.enable = true;
    deadnix.enable = true;
    statix = {
      enable = true;
      disabled-lints = [ "empty_pattern" "repeated_keys" ];
    };

    # Configs
    jsonfmt.enable = false; # interferes with prettier;
    taplo.enable = true;
    yamlfmt.enable = true;
    actionlint.enable = true;

    # Scripts
    shfmt.enable = false;
    beautysh.enable = true;
    ruff-format = {
      enable = true;
      lineLength = 120;
    };
  };

  settings.formatter = {
    yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
    actionlint.options = [ "-ignore" "label \".+\" is unknown" "-ignore" "\".+\" is potentially untrusted" ];
  };
}
