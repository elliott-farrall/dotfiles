{ inputs
, pkgs
, system
, ...
}:

#TODO - Rebuild devshell

let
  inherit (pkgs.devshell) mkShell;
in
mkShell {
  devshell = {
    startup = {
      pre-commit = {
        text = inputs.self.checks.${system}.pre-commit.shellHook;
      };
      clear = {
        text = "printf '\n%.0s' {1..30}";
        deps = [ "pre-commit" ];
      };
    };
  };
}
