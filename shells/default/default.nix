{ mkShell
, inputs
, pkgs
, ...
}:

mkShell {
  inherit (inputs.self.checks.x86_64-linux.pre-commit) shellHook;
  buildInputs = inputs.self.checks.x86_64-linux.pre-commit.enabledPackages;

  packages = with pkgs; [
    agenix
    xdg-ninja
    nix-init
    nh
    fup-repl
    snowfallorg.flake
  ];

  EDITOR = "code -w";
}
