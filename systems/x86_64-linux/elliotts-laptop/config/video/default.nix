{ pkgs
, ...
}:

{
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  #   extraPackages = with pkgs; [
  #     intel-compute-runtime
  #   ];
  # };

  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    # xkb.layout = "gb";
  };

  boot.loader.grub.gfxmodeEfi = "2256x1504";

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings.monitor = [
        "eDP-1, 2256x1504@60, auto, 1.333333"
        ", preferred, auto, auto"
      ];
    }
  ];
}
