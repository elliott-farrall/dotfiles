#TODO Impermanance / Erase Your Darlings
# test

{
  inputs = {
    # For when https://github.com/NixOS/nix/pull/8892 gets merged
    flake-schemas = {
      url = "github:DeterminateSystems/flake-schemas";
    };
    extra-schemas = {
      url = "github:ElliottSullingeFarrall/extra-schemas";
    };

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
      url = "github:ElliottSullingeFarrall/agenix";
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

    rofi-plugins = {
      url = "github:ElliottSullingeFarrall/rofi-plugins";
      inputs = {
        snowfall-lib.follows = "snowfall-lib";
        pre-commit-hooks.follows = "pre-commit-hooks";
        nixpkgs.follows = "nixpkgs";
      };
    };
    code-insiders = {
      url = "github:iosmanthus/code-insiders-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ldz-apps = {
      url = "github:ElliottSullingeFarrall/LDZ-Apps/legacy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.snowfall-lib.mkFlake
    {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        snowfall-flake.overlays.default
        agenix.overlays.default
        catnerd.overlays.default
        rofi-plugins.overlays.default
        code-insiders.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        agenix.nixosModules.default
        catnerd.nixosModules.catnerd
      ];
      homes.modules = with inputs; [
        agenix.homeManagerModules.default
        catnerd.homeModules.catnerd
      ];

      systems.hosts = {
        "elliotts-laptop" = {
          modules = with inputs; [
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
      };

    } // { schemas = inputs.flake-schemas.schemas // inputs.extra-schemas.schemas; };
}
