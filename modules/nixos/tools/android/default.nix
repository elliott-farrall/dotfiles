{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.tools.android;
  inherit (cfg) enable;
in
{
  options = {
    tools.android.enable = lib.mkEnableOption "Android development tools";
  };

  config = lib.mkIf enable {
    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
      heimdall
    ];
  };
}
