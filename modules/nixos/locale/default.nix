{ lib
, ...
}:

#TODO - Simplify this module

{
  imports = [
    ./locales/uk.nix
  ];

  options = {
    locale = lib.mkOption {
      description = "The locale to use.";
      type = lib.types.enum [
        "uk"
      ];
      default = "uk";
    };
  };

  config = {
    console.useXkbConfig = true;
    services.kmscon.useXkbConfig = true;
  };
}
