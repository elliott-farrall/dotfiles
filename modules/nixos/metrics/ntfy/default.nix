{ lib
, pkgs
, host
, config
, ...
}:

{
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "http://${host}";
      listen-http = ":2586";
    };
  };

  system.activationScripts.notify.text = ''
    ${lib.getExe pkgs.curl} \
      -H "Title: System Activation" \
      -d "Successfully activated ${host}" \
    ${config.services.ntfy-sh.settings.base-url}${config.services.ntfy-sh.settings.listen-http}/${host} > /dev/null 2>&1
  '';
}
