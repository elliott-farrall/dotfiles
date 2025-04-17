{ ...
}:

{
  age.secrets = {
    # Get pppoe credentials from ISP
    "pppoe/username" = {
      file = ./username.age;
      substitutes = [ "/etc/ppp/options" ];
    };
    "pppoe/password" = {
      file = ./password.age;
      substitutes = [ "/etc/ppp/options" ];
    };
  };

  environment.etc."ppp/options".text = ''
    name "@pppoe/username@"
    password "@pppoe/password@"
  '';

  services.pppd = {
    enable = true;

    peers."isp" = {
      enable = true;
      autostart = true;

      config = ''
        plugin rp-pppoe.so wan

        persist
        maxfail 0
        holdoff 5

        noipdefault
        defaultroute
      '';
    };
  };
}
