{ lib
, config
, ...
}:

#TODO - Implement silent boot module

let
  cfg = config.boot.silent;
  inherit (cfg) enable;
in
{
  # disabledModules = [
  #   "system/boot/stage-1.nix"
  #   "system/boot/stage-2.nix"
  # ];
  # imports = [
  #   ./boot/stage-1.nix
  #   ./boot/stage-2.nix
  # ];

  options = {
    boot.silent.enable = lib.mkEnableOption "silent boot";
  };

  config = lib.mkIf enable {
    boot = {
      # Hide stage 1 and 2 messages
      initrd.verbose = false;

      # Hide initrd and systemd messages
      kernelParams = [ "quiet" "udev.log_level=3" "systemd.show_status=false" ];
    };
  };
}
