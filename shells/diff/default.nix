{ mkShell
, pkgs
, ...
}:

mkShell {
  name = "diff";

  packages = with pkgs; [ nvd ];
}
