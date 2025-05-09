{ lib
, config
, ...
}:

let
  cfg = config.greeter;
  enable = cfg != null;
in
{
  options = {
    greeter = lib.mkOption {
      description = "The greeter to use.";
      type = lib.types.enum [
        "regreet"
        "tuigreet"
        null
      ];
      default = null;
    };
  };

  config = lib.mkIf enable {
    services.greetd.enable = true;
  };
}
