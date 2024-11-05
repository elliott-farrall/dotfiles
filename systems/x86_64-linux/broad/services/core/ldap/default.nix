{ ...
}:

{
  age.secrets = {
    secret.substitutions = [
      "/etc/broad/ldap/config.toml"
    ];
    password.substitutions = [
      "/etc/broad/ldap/config.toml"
    ];
  };

  environment.etc."broad/ldap/config.toml".source = ./config.toml;
}
