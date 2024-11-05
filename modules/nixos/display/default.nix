{ config
, lib
, ...
}:

let
  cfg = config.display;
  inherit (cfg) enable width height scale;
in
{
  options = {
    display = {
      enable = lib.mkEnableOption "display configuration";
      width = lib.mkOption {
        type = lib.types.int;
        default = 1920;
        description = "Width of the display";
      };
      height = lib.mkOption {
        type = lib.types.int;
        default = 1080;
        description = "Height of the display";
      };
      refresh = lib.mkOption {
        type = lib.types.int;
        default = 60;
        description = "Refresh rate of the display";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "Scale of the display";
      };
    };
  };

  config = lib.mkIf enable {
    boot = {
      loader.grub.gfxmodeEfi = "${toString width}x${toString height}";
      plymouth.extraConfig = "DeviceScale=${toString (builtins.ceil scale)}";
    };
  };
}
