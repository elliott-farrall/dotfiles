{ host
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
}
