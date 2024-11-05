{ ...
}:

{
  age.secrets = {
    speedtest-tracker = {
      file = ./key.age;
      path = "/etc/broad/speedtest-tracker/key";
      substitutions = [ "/etc/broad/speedtest-tracker/secrets.env" ];
    };
  };

  environment.etc."broad/speedtest-tracker/secrets.env".source = ./secrets.env;
}
