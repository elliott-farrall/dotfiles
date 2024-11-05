{ lib
, ...
}:

{
  options = {
    locker = lib.mkOption {
      type = lib.types.enum [
        "gtklock"
        ""
      ];
      default = "";
      description = "The locker to use.";
    };
  };
}
