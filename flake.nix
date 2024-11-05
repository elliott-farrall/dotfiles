{
  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    # Schemas
    # For when https://github.com/NixOS/nix/pull/8892 gets merged
    flake-schemas = {
      url = "github:DeterminateSystems/flake-schemas";
    };
    extra-schemas = {
      url = "github:ElliottSullingeFarrall/extra-schemas";
    };

    # Dependencies
    systems = {
      url = "github:nix-systems/default";
    };
    flake-compat = {
      url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.systems.follows = "systems";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    # Core
    snowfall-lib = {
      url = "github:ElliottSullingeFarrall/lib";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils-plus.follows = "flake-utils-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Environment & Deployment
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    github-nix-ci = {
      url = "github:juspay/github-nix-ci";
    };

    # Modules
    agenix = {
      url = "github:ElliottSullingeFarrall/agenix";
      inputs.systems.follows = "systems";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catnerd = {
      url = "github:ElliottSullingeFarrall/catnerd";
      inputs.snowfall-lib.follows = "snowfall-lib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      inputs.snowfall-flake.follows = "snowfall-flake";
    };

    # Tools
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.flake-compat.follows = "flake-compat";
      inputs.snowfall-lib.follows = "snowfall-lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    code-insiders = {
      url = "github:iosmanthus/code-insiders-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mathematica = {
      url = "file+https://pub-e3715b1d1c4941f7affe3edd4c690e8c.r2.dev/Mathematica_14.0.0_LINUX.sh";
      flake = false;
    };
    rofi-plugins = {
      url = "github:ElliottSullingeFarrall/rofi-plugins";
      inputs.snowfall-lib.follows = "snowfall-lib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };
    rofi-mixer = {
      url = "github:joshpetit/rofi-mixer";
      flake = false;
    };
    rofi-network-manager = {
      url = "github:P3rf/rofi-network-manager";
      flake = false;
    };
    rofi-wifi-menu = {
      url = "github:ericmurphyxyz/rofi-wifi-menu";
      flake = false;
    };
    jtbl = {
      url = "github:kellyjonbrazil/jtbl";
      flake = false;
    };
    ldz-desktop = {
      url = "github:ElliottSullingeFarrall/ldz-desktop/dev";
      inputs.poetry2nix.follows = "poetry2nix";
      inputs.snowfall-lib.follows = "snowfall-lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
      };
    in
    lib.mkFlake
      {
        channels-config = {
          allowUnfree = true;
        };

        overlays = with inputs; [
          snowfall-flake.overlays.default
          agenix.overlays.default
          catnerd.overlays.default
          rofi-plugins.overlays.default
          code-insiders.overlays.default
          ldz-desktop.overlays.default
        ];

        systems.modules.nixos = with inputs; [
          nix-index-database.nixosModules.nix-index
          agenix.nixosModules.default
          catnerd.nixosModules.catnerd
        ];
        homes.modules = with inputs; [
          nix-index-database.hmModules.nix-index
          agenix.homeManagerModules.default
          catnerd.homeModules.catnerd
        ];

        systems.hosts = {
          broad = {
            modules = with inputs; [
              systems/x86_64-linux/broad/hardware-configuration.nix
              nixos-hardware.nixosModules.common-pc
            ];
          };
          lima = {
            modules = with inputs; [
              systems/x86_64-linux/lima/hardware-configuration.nix
              nixos-hardware.nixosModules.framework-12th-gen-intel
              systems/x86_64-linux/lima/display-configuration.nix
            ];
          };
          runner = {
            modules = with inputs; [
              systems/x86_64-linux/runner/hardware
              nixos-hardware.nixosModules.common-pc
              disko.nixosModules.disko
              github-nix-ci.nixosModules.default
            ];
          };
        };

        templates = {
          python.description = "Python development environment";
          ruby.description = "Ruby development environment";
        };

      } // {
      # schemas = inputs.flake-schemas.schemas // inputs.extra-schemas.schemas;

      deploy = {
        sshUser = "deploy";
        nodes.lima = {
          hostname = "lima";
          user = "root";
          profiles.system.path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.lima;
        };
        nodes.runner = {
          hostname = "runner";
          user = "root";
          profiles.system.path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.runner;
        };
      };
    };
}
