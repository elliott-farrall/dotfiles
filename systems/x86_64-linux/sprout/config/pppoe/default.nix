{ ...
}:

{
  age.secrets = {
    "isp/username" = {
      file = ./username.age;
      substitutions = [
        "/etc/ppp/peers/isp"
        "/etc/ppp/pap-secrets"
        "/etc/ppp/chap-secrets"
      ];
    };
    "isp/password" = {
      file = ./password.age;
      substitutions = [
        "/etc/ppp/pap-secrets"
        "/etc/ppp/chap-secrets"
      ];
    };
  };

  environment.etc = {
    "ppp/pap-secrets" = {
      text = "@username@ * @password@";
      mode = "0600";
    };
    "ppp/chap-secrets" = {
      text = "@username@ * @password@";
      mode = "0600";
    };
  };

  services.pppd = {
    enable = true;

    peers."isp".config = ''
      plugin pppoe.so ont
      ifname wan

      name "@username@"
      mtu 1492

      defaultroute
    '';
  };
}
