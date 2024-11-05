{ ...
}:

{
  age.secrets = {
    cloudflare-url = {
      file = ./cloudflare-url.age;
      path = "/etc/broad/backup/cloudflare-url";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
    cloudflare-id = {
      file = ./cloudflare-id.age;
      path = "/etc/broad/backup/cloudflare-id";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
    cloudflare-key = {
      file = ./cloudflare-key.age;
      path = "/etc/broad/backup/cloudflare-key";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
    backup-key = {
      file = ./key.age;
      path = "/etc/broad/backup/key";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
    backup-secret = {
      file = ./secret.age;
      path = "/etc/broad/backup/secret";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
    backup-token = {
      file = ./token.age;
      path = "/etc/broad/backup/token";
      substitutions = [ "/etc/broad/backup/secrets.env" ];
    };
  };

  environment.etc."broad/backup/secrets.env".source = ./secrets.env;
}
