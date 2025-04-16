{ lib
, osConfig ? null
, ...
}:

#TODO - Better integration of lockers between nixos and home-manager

{
  options = {
    locker = lib.mkOption {
      type = lib.types.enum [
        "gtklock"
        "hyprlock"
        null
      ];
      default = null;
      description = "The locker to use.";
    };
  };

  config = lib.mkIf (osConfig != null) {
    inherit (osConfig) locker;
  };
}
