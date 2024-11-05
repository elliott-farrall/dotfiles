{ ...
}:

{
  age.secrets = {
    tubearchivist = {
      file = ./key.age;
      path = "/etc/broad/tubearchivist/key";
    };
    secret.substitutions = [ "/etc/broad/tubearchivist/secrets.env" ];
    password.substitutions = [ "/etc/broad/tubearchivist/secrets.env" ];
  };

  environment.etc."broad/tubearchivist/secrets.env".source = ./secrets.env;
}
