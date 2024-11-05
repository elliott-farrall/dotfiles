{ mkShell
, pkgs
, inputs
, system
, ...
}:

mkShell {
  name = "ruby";

  buildInputs = inputs.self.checks.${system}.pre-commit.enabledPackages;
  packages = with pkgs; [
    bundler
  ];

  inherit (inputs.self.checks.${system}.pre-commit) shellHook;
}
