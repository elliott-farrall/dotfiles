{ ...
}:

{
  age.secrets = {
    portainer = {
      file = ./key.age;
      path = "/etc/broad/portainer/key";
    };
  };
}
