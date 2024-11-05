{ ...
}:

{
  age.secrets = {
    ddns = {
      file = ./cloudflare.age;
      path = "/etc/broad/ddns/cloudflare";
    };
  };
}
