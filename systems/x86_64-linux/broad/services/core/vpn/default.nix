{ ...
}:

{
  age.secrets = {
    wireguard = {
      file = ./key.age;
      path = "/etc/broad/vpn/key";
      substitutions = [ "/etc/broad/vpn/secrets.env" ];
    };
  };

  environment.etc."broad/vpn/secrets.env".source = ./secrets.env;
}
