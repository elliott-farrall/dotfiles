{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.services.printing;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    services.printing.drivers = [
      (pkgs.writeTextDir "share/cups/model/Samsung_X7600_Series.ppd" (builtins.readFile ./Samsung_X7600_Series.ppd))
    ];

    hardware.printers.ensurePrinters = lib.singleton {
      name = "SurreyPrint";
      description = "Surrey Print Service";
      location = "University of Surrey";

      deviceUri = "lpd://es00569@printservice.surrey.ac.uk/surreyprint";
      model = "Samsung_X7600_Series.ppd";
      ppdOptions = {
        Option1 = "True"; # Duplexer
        Duplex = "DuplexNoTumble";
        PageSize = "A4";
      };
    };
  };
}
