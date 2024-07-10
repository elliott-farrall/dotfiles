{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.locker.gtklock;
  inherit (cfg) enable;
in
{
  options = {
    locker.gtklock.enable = lib.mkEnableOption "gtklock screen locker";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [ gtklock ];
  };
}
