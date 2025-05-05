{ lib
, pkgs
, format
, ...
}:

{
  programs.nh = lib.mkIf (format == "linux") {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 30 --keep-since 14d";
    };
  };

  programs.nix-index-database.comma.enable = true;

  environment.systemPackages = with pkgs; [
    agenix
    devbox
    devenv
    nil
    nix-fast-build
    nix-info
    nix-init
    nix-inspect
    nix-melt
    nix-output-monitor
    nix-tree
    nix-update
    nixd
    nixpkgs-hammering
    nixos-facter
  ];
}
