{ lib
, config
, ...
}:

#TODO - Test systemd-lock-handler

let
  cfg = config.locker;
  enable = cfg != null;
in
{
  options = {
    locker = lib.mkOption {
      description = "The locker to use.";
      type = lib.types.enum [
        "gtklock"
        "hyprlock"
        null
      ];
      default = null;
    };
  };

  config = lib.mkIf enable {
    services.systemd-lock-handler.enable = true;
  };
}
