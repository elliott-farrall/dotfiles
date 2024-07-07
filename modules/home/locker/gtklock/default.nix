{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.locker.gtklock;
  enable = cfg.enable;
in
{
  options = {
    locker.gtklock.enable = lib.mkEnableOption "gtklock screen locker";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [ gtklock ];
  };
}
