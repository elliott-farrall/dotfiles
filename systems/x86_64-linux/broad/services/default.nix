{ ...
}:

{
  imports = [
    ./compose.nix

    ./core
    ./games
    ./media
    ./monitor
  ];

  age.secrets = {
    secret = {
      file = ./secret.age;
      path = "/etc/broad/secret";
    };
    password = {
      file = ./password.age;
      path = "/etc/broad/password";
    };
  };
}
