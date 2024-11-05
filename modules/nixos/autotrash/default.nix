{ pkgs
, ...
}:

{
  services.cron = {
    enable = true;
    systemCronJobs = [ "@hourly ${pkgs.python312Packages.autotrash}/bin/autotrash -td 30" ];
  };
}
