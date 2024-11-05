{ ...
}:

{
  age.secrets = {
    igdb-id = {
      file = ./igdb-id.age;
      path = "/etc/broad/romm/igdb-id";
      substitutions = [ "/etc/broad/romm/secrets.env" ];
    };
    igdb = {
      file = ./igdb.age;
      path = "/etc/broad/romm/igdb";
      substitutions = [ "/etc/broad/romm/secrets.env" ];
    };
    steamgriddb = {
      file = ./steamgriddb.age;
      path = "/etc/broad/romm/steamgriddb";
      substitutions = [ "/etc/broad/romm/secrets.env" ];
    };
    secret.substitutions = [ "/etc/broad/romm/secrets.env" ];
  };

  environment.etc."broad/romm/secrets.env".source = ./secrets.env;
}
