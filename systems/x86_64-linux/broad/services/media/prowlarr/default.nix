{ ...
}:

{
  age.secrets = {
    prowlarr = {
      file = ./key.age;
      path = "/etc/broad/prowlarr/key";
    };
    nzbgeek = {
      file = ./indexers/nzbgeek.age;
      path = "/etc/broad/prowlarr/indexers/nzbgeek";
    };
  };
}
