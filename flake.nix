#TODO Impermanance / Erase Your Darlings

{
  inputs = {
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    catnerd = {
      url = "github:ElliottSullingeFarrall/catnerd";
      inputs = {
        snowfall-lib.follows = "snowfall-lib";
        snowfall-flake.follows = "snowfall-flake";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ldz-apps = {
      url = "github:ElliottSullingeFarrall/LDZ-Apps/legacy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;

    channels-config = {
      allowUnfree = true;
    };

    overlays = with inputs; [
      snowfall-flake.overlays.default
      agenix.overlays.default
      catnerd.overlays.default
    ];

    systems.modules = with inputs; [
      agenix.nixosModules.default
    ];
    homes.modules = with inputs; [
      agenix.homeManagerModules.default
    ];

    systems.hosts = {
      "elliotts-laptop" = {
        modules = with inputs; [
          nixos-hardware.nixosModules.framework-12th-gen-intel
          catnerd.nixosModules.catnerd
        ];
      };
    };
    homes.users = {
      "elliott@elliotts-laptop" = {
        modules = with inputs; [
          catnerd.homeModules.catnerd
        ];
      };
      "greeter@elliotts-laptop" = {
        modules = with inputs; [
          catnerd.homeModules.catnerd
        ];
      };
    };

  };
}
