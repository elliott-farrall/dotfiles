{ ...
}:

{
  age.secrets = {
    password.substitutions = [
      "/etc/broad/auth/config.yaml"
    ];
    secret.substitutions = [
      "/etc/broad/auth/config.yaml"
    ];
  };

  environment.etc."broad/auth/config.yaml".source = ./config.yaml;
}
