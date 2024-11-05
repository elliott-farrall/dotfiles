{ ...
}:

{
  age.secrets = {
    sabnzbd = {
      file = ./key.age;
      path = "/etc/broad/sabnzbd/key";
      substitutions = [
        "/etc/broad/sabnzbd/config.ini"
      ];
    };
    nzb = {
      file = ./nzb.age;
      path = "/etc/broad/sabnzbd/nzb";
      substitutions = [
        "/etc/broad/sabnzbd/config.ini"
      ];
    };
    password.substitutions = [
      "/etc/broad/sabnzbd/config.ini"
    ];
  };

  environment.etc."broad/sabnzbd/config.ini".source = ./config.ini;
}
