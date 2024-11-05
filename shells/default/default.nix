{ mkShell
, pkgs
, inputs
, system
, ...
}:

mkShell {
  name = "dotfiles";

  inherit (inputs.self.checks.${system}.pre-commit) shellHook;
  buildInputs = inputs.self.checks.${system}.pre-commit.enabledPackages;

  packages = with pkgs; [
    snowfallorg.flake
    nix-inspect
    nix-melt
    fup-repl
    agenix

    nix-init

    xdg-ninja
  ];
}
