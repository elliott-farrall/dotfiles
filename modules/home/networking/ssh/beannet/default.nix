{ config
, ...
}:

{
  age.secrets."users/elliott/key".file = ./elliott.age;

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
      user = "elliott";
      identityFile = config.age.secrets."users/elliott/key".path;
      match = ''
        host lima exec "nc -z localhost %p"
      '';
    };
    lima-external = {
      hostname = "lima.tail4ae93.ts.net";
      user = "elliott";
      match = ''
        host lima !exec "nc -z localhost %p"
      '';
    };
  };
}
