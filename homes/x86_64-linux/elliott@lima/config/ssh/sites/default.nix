{ config
, ...
}:

{
  age.secrets = {
    key-gh.file = ./github.age;
    key-pa.file = ./python-anywhere.age;
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = config.age.secrets.key-gh.path;
    };

    "ssh.eu.pythonanywhere.com" = {
      user = "ElliottSF";
      identityFile = config.age.secrets.key-pa.path;
    };
  };
}
