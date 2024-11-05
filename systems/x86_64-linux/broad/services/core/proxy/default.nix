{ ...
}:

{
  age.secrets = {
    proxy = {
      file = ./cloudflare.age;
      path = "/etc/broad/proxy/cloudflare";
    };
  };

  environment.etc."broad/proxy/config.yaml".source = ./config.yaml;
  environment.etc."broad/proxy/routes.yaml".source = ./routes.yaml;
}
