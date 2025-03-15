{ config
, ...
}:

{
  age.secrets = {
    "users/root/key" = {
      file = ./root.age;
      path = "${config.home.homeDirectory}/.ssh/keys/root";
    };
    "users/elliott/key" = {
      file = ./elliott.age;
      path = "${config.home.homeDirectory}/.ssh/keys/elliott";
    };
  };

  programs.ssh.matchBlocks = {
    broad-internal = {
      hostname = "localhost";
      port = 2222;
      user = "elliott";
      identityFile = config.age.secrets."users/elliott/key".path;
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      match = ''
        host broad exec "nc -z localhost %p"
      '';
    };
    broad-external = {
      hostname = "broad.tail4ae93.ts.net";
      user = "elliott";
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      match = ''
        host broad !exec "nc -z localhost %p"
      '';
    };

    lima-internal = {
      hostname = "localhost";
      user = "root";
      identityFile = config.age.secrets."users/root/key".path;
      match = ''
        host lima exec "nc -z localhost %p"
      '';
    };
    lima-external = {
      hostname = "lima";
      user = "root";
      match = ''
        host lima !exec "nc -z localhost %p"
      '';
    };
  };
}
