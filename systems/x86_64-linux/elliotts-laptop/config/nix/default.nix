{ pkgs
, ...
}:

{
  documentation.nixos.enable = false;

  system = {
    autoUpgrade = {
      enable = false;
      allowReboot = true;
    };
  };

  nix = {
    package = pkgs.nixVersions.latest;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      min-free = "${toString (50 * 1024 * 1024 * 1024)}";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
