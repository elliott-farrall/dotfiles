{ lib
, pkgs
, format
, ...
}:

#TODO - Test autotrash

let
  enable = format == "linux";
in
{
  config = lib.mkIf enable {
    services.cron = {
      enable = true;
      systemCronJobs = [ "@hourly ${pkgs.python312Packages.autotrash}/bin/autotrash -td 30" ];
    };
  };
}
