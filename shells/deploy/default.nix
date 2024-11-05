{ mkShell
, pkgs
, ...
}:

mkShell {
  name = "deploy";

  packages = with pkgs; [ deploy-rs ];
}
