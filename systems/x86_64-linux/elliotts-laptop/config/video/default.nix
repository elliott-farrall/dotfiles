{ pkgs
, ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    xkb.layout = "gb";
  };
}
