{ ...
}:

{
  age.secrets = {
    jellyfin = {
      file = ./key.age;
      path = "/etc/broad/jellyfin/key";
    };
  };
}
