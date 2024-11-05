{
  projectRootFile = ".git/config";

  settings.global.excludes = [
    "LICENSE.md"
    ".editorconfig"
    "*.env"
    "*.conf"
    "*.ini"
    "*.age"
    "*.hash"
    "*.ppd"
    "*.jpg"
    "*.code-workspace"
    "templates/**/*"
    "modules/nixos/boot/silent/boot/*"
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
    jsonfmt.enable = true;
    taplo.enable = true;
    yamlfmt.enable = true;
    actionlint.enable = true;

    # Scripts
    shfmt.enable = true;
    beautysh.enable = true;
  };

  settings.formatter = {
    yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
    actionlint.options = [ "-ignore" "label \".+\" is unknown" ];
  };
}
