{ lib
, ...
}:

{
  imports = [
    ./locale-uk.nix
  ];

  options = {
    locale = lib.mkOption {
      type = lib.types.enum [
        "uk"
        ""
      ];
      default = "";
      description = "The locale to use.";
    };
  };
}
