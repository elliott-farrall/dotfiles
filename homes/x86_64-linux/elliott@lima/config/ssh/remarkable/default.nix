{ config
, ...
}:

{
  age.secrets.remarkable.file = ./key.age;

  programs.ssh.matchBlocks = {
    reMarkable = {
      hostname = "192.168.225.133";
      user = "root";
      identityFile = config.age.secrets.remarkable.path;
      extraOptions = {
        PubkeyAcceptedKeyTypes = "ssh-rsa";
      };
    };
  };
}
