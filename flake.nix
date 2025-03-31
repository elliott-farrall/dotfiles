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
          catppuccin-vsc.overlays.default
          code-insiders.overlays.default
          devshell.overlays.default
          nix-auto-follow.overlays.default
          nix-vscode-extensions.overlays.default
          rofi-plugins.overlays.default
        ];

        systems.modules.nixos = with inputs; [
          agenix.nixosModules.default
          agenix-substitutes.nixosModules.default
          comin.nixosModules.comin
          impermanence.nixosModules.impermanence
          nix-index-database.nixosModules.nix-index
          stylix.nixosModules.stylix
        ];
        homes.modules = with inputs; [
          agenix.homeManagerModules.default
          agenix-substitutes.homeManagerModules.default
          impermanence.homeManagerModules.impermanence
          nix-index-database.hmModules.nix-index
          rclonix.homeModules.default
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
              github-nix-ci.nixosModules.default
              # Move to shared modules
              nixos-facter-modules.nixosModules.facter
              disko.nixosModules.disko
            ];
          };
        };

        outputs-builder = channels: {
          formatter = lib.treefmt-nix.mkWrapper channels.nixpkgs {
            projectRootFile = ".git/config";

            settings.global.excludes = [
              "LICENSE.md"
              ".editorconfig"
              "*.env"
              "*.ini"
              "*.conf"
              "*.age"
              "*.hash"
              "*.ppd"
              "*.jpg"
              "templates/**"
              "secrets.nix"
            ];

            programs = {
              prettier.enable = true;

              # Nix
              nixpkgs-fmt.enable = true;
              deadnix.enable = true;
              statix = {
                enable = true;
                disabled-lints = [ "empty_pattern" "repeated_keys" ];
              };

              # Configs
              jsonfmt.enable = true;
              taplo.enable = true;
              yamlfmt.enable = true;
              actionlint.enable = true;

              # Scripts
              shfmt.enable = true;
              beautysh.enable = true;
            };

            settings.formatter = {
              yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
              actionlint.options = [ "-ignore" "label \".+\" is unknown" ];

              nixpkgs-fmt.excludes = [ "modules/nixos/boot/silent/boot/*" "**/hardware.nix" ];
              deadnix.excludes = [ "modules/nixos/boot/silent/boot/*" "**/hardware.nix" ];
              statix.excludes = [ "modules/nixos/boot/silent/boot/*" "**/hardware.nix" ];
              shfmt.excludes = [ "modules/nixos/boot/silent/boot/*" ];
              beautysh.excludes = [ "modules/nixos/boot/silent/boot/*" ];
            };
          };
        };

        templates = {
          overlay.description = "Overlay template for snowfall-lib.";
        };

      } // {
      # schemas = inputs.flake-schemas.schemas // inputs.extra-schemas.schemas;

      deploy = {
        sshUser = "root";
        nodes.lima = {
          hostname = "lima";
          profiles.system.path = lib.deploy-rs.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.lima;
        };
        # nodes.runner = {
        #   hostname = "runner";
        #   profiles.system.path = lib.deploy-rs.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.runner;
        # };
      };
    };

  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix-substitutes.url = "github:elliott-farrall/agenix-substitutes";
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
    code-insiders.url = "github:iosmanthus/code-insiders-flake";
    comin.url = "github:nlewo/comin";
    deploy-rs.url = "github:serokell/deploy-rs";
    devshell.url = "github:numtide/devshell";
    disko.url = "github:nix-community/disko";
    flox.url = "github:flox/flox";
    garnix-lib.url = "github:garnix-io/garnix-lib";
    github-nix-ci.url = "github:juspay/github-nix-ci";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # nix-monitored.url = "github:ners/nix-monitored";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    rclonix.url = "github:elliott-farrall/rclonix/legacy";
    rofi-plugins.url = "github:elliott-farrall/rofi-plugins?rev=990fbb21bb5152ba116571704f1ba99d3dbb377f";
    snowfall-lib.url = "github:snowfallorg/lib";
    stylix.url = "github:danth/stylix";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Schemas
    # For when https://github.com/NixOS/nix/pull/8892 gets merged
    flake-schemas = {
      url = "github:DeterminateSystems/flake-schemas";
    };
    extra-schemas = {
      url = "github:elliott-farrall/extra-schemas";
    };
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
