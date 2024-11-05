{ config
, ...
}:

{
  age.secrets.key-beannet.file = ./legacy.age;

  programs.ssh.matchBlocks = {
    beannet = {
      hostname = "bean-machine.tail4ae93.ts.net";
      user = "root";
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    };
    beanmachine = {
      hostname = "192.168.1.2";
      user = "root";
      identityFile = config.age.secrets.key-beannet.path;
      proxyJump = "beannet";
    };
  };
}
