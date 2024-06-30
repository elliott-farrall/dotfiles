{ pkgs
, ...
}:

{
  home.packages = with pkgs; [
    # Nix IDE
    nixd
    nixpkgs-fmt

    comma
  ];
}
