{
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib { inherit inputs; src = ./.; };
    in
    lib.mkFlake
      {
        channels-config = {
          allowUnfree = true;
        };

        overlays = with inputs; [
          agenix.overlays.default
          code-insiders.overlays.default
          devshell.overlays.default
          nix4vscode.overlays.forVscode
          nix-auto-follow.overlays.default
          nix-vscode-extensions.overlays.default
        ];

        systems.modules.nixos = with inputs; [
          agenix.nixosModules.default
          agenix-substitutes.nixosModules.default
          catppuccin.nixosModules.catppuccin
          comin.nixosModules.comin
          impermanence.nixosModules.impermanence
          nix-index-database.nixosModules.nix-index
          stylix.nixosModules.stylix

        ];
        homes.modules = with inputs; [
          agenix.homeManagerModules.default
          agenix-substitutes.homeManagerModules.default
          catppuccin.homeModules.catppuccin
          impermanence.homeManagerModules.impermanence
          nix-index-database.hmModules.nix-index
          stylix.homeManagerModules.stylix
        ];

        systems.hosts = {
          broad = {
            modules = with inputs; [
              nixos-hardware.nixosModules.common-pc
              systems/x86_64-linux/broad/system
            ];
          };
          lima = {
            modules = with inputs; [
              nixos-hardware.nixosModules.framework-12th-gen-intel
              systems/x86_64-linux/lima/system
            ];
          };
          runner = {
            modules = with inputs; [
              nixos-hardware.nixosModules.common-pc
              systems/x86_64-linux/runner/system
              garnix-lib.nixosModules.garnix
            ];
          };
          sprout = {
            modules = with inputs; [
              nixos-hardware.nixosModules.common-pc
              systems/x86_64-linux/sprout/system
              disko.nixosModules.disko
              nixos-facter-modules.nixosModules.facter
            ];
          };
        };

        outputs-builder = channels: {
          formatter = import ./formatter { inherit lib; pkgs = channels.nixpkgs; };
        };

        templates = lib.listToAttrs (map
          (name: {
            inherit name;
            value.description = "${lib.removePrefix "snowfall-" name} template for snowfall-lib.";
          })
          (builtins.filter (name: lib.hasPrefix "snowfall-" name) (builtins.attrNames (builtins.readDir ./templates))));

        schemas = lib.mergeAttrsList (with inputs; [
          flake-schemas.schemas
          extra-schemas.schemas
        ]); # For when https://github.com/NixOS/nix/pull/8892 gets merged

        toplevel = lib.mergeAttrsList [
          (lib.mapAttrs (_attr: cfg: cfg.config.system.build.toplevel) inputs.self.nixosConfigurations)
          (lib.mapAttrs (_attr: cfg: cfg.activationPackage) inputs.self.homeConfigurations)
        ];

        deploy.nodes = lib.mapAttrs
          (hostname: cfg: {
            inherit hostname;
            sshUser = "root";
            profiles.system.path = lib.deploy-rs.x86_64-linux.activate.nixos cfg;
          })
          inputs.self.nixosConfigurations;
      };

  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix-substitutes.url = "github:elliott-farrall/agenix-substitutes";
    catppuccin.url = "github:catppuccin/nix";
    code-insiders.url = "github:iosmanthus/code-insiders-flake";
    comin.url = "github:nlewo/comin";
    deploy-rs.url = "github:serokell/deploy-rs";
    devshell.url = "github:numtide/devshell";
    disko.url = "github:nix-community/disko";
    extra-schemas.url = "github:elliott-farrall/extra-schemas";
    flake-schemas.url = "github:DeterminateSystems/flake-schemas";
    flox.url = "github:flox/flox";
    garnix-lib.url = "github:garnix-io/garnix-lib";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    nix4vscode.url = "github:nix-community/nix4vscode";
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # nix-monitored.url = "github:ners/nix-monitored";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    rand-nix.url = "github:figsoda/rand-nix";
    snowfall-lib.url = "github:snowfallorg/lib";
    stylix.url = "github:danth/stylix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://cache.flox.dev"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };
}
