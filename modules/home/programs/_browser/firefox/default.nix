{ osConfig ? null
, config
, lib
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "firefox";

  inherit (lib.internal) mkDefaultApplications;
in
{
  config = lib.mkIf enable {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = osConfig.programs.firefox.nativeMessagingHosts.packages or [ ];
    };

    home.sessionVariables.BROWSER = "firefox";

    xdg.mimeApps.defaultApplications = mkDefaultApplications "firefox.desktop" [
      "text/html"
      "application/pdf"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
      "image/jpeg"
      "image/png"
      "image/svg"
      "image/gif"
      "image/webp"
      "image/mp4"
      "image/mpeg"
      "image/webm"
    ];
  };
}
