{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.profiles.uos;
  enable = cfg.enable && config.services.printing.enable;

  driver = pkgs.writeTextDir "share/cups/model/Samsung_X7600_Series.ppd" (builtins.readFile ./Samsung_X7600_Series.ppd);
in
{
  config = lib.mkIf enable {
    services.printing.drivers = [ driver ];

    hardware.printers.ensurePrinters = [
      {
        name = "SurreyPrint";
        description = "Surrey Print Service (Old)";
        location = "University of Surrey";

        deviceUri = "lpd://es00569@printservice.surrey.ac.uk/surreyprint";
        model = "Samsung_X7600_Series.ppd";
        ppdOptions = {
          Option1 = "True"; # Duplexer
          Duplex = "DuplexNoTumble";
          PageSize = "A4";
        };
      }
      {
        name = "PrintSurrey";
        description = "Surrey Print Service (New)";
        location = "University of Surrey";

        deviceUri = "lpd://es00569@printservice.surrey.ac.uk/printsurrey";
        model = "Samsung_X7600_Series.ppd";
        ppdOptions = {
          Option1 = "True"; # Duplexer
          Duplex = "DuplexNoTumble";
          PageSize = "A4";
        };
      }
    ];
  };
}
