{
  projectRootFile = ".git/config";
  settings.global.excludes = [
    ".editorconfig"
    "Gemfile"
  ];
  programs = {
    actionlint.enable = true;
    beautysh.enable = true;
    deadnix.enable = true;
    jsonfmt.enable = true;
    mdformat.enable = true;
    nixpkgs-fmt.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
    statix.enable = true;
    taplo.enable = true;
    yamlfmt.enable = true;
  };
  settings.formatter = {
    yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
  };
}
