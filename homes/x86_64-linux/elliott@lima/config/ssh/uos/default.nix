{ config
, ...
}:

{
  age.secrets.key-uos.file = ./key.age;

  programs.ssh.matchBlocks = {
    AccessEPS = {
      hostname = "access.eps.surrey.ac.uk";
      user = "es00569";
      identityFile = config.age.secrets.key-uos.path;
      forwardX11 = true;
      forwardX11Trusted = true;
    };
    MathsCompute01 = {
      hostname = "maths-compute01";
      user = "es00569";
      identityFile = config.age.secrets.key-uos.path;
      forwardX11 = true;
      forwardX11Trusted = true;
      proxyJump = "AccessEPS";
    };
  };
}
