{ lib
, ...
}:

{
  capitalise = str: "${lib.strings.toUpper (lib.strings.substring 0 1 str)}${lib.strings.substring 1 (builtins.stringLength str - 1) str}";

  mkDefaultApplications = app: mimes: lib.genAttrs mimes (_mime: app);

  mkMatchBlock = { hostname, user, port ? 22, identityFile, extraOptions ? { } }:
    {
      "${user}@${hostname}.local" = {
        inherit user port identityFile extraOptions;
        hostname = "localhost";
        match = ''
          user ${user} host ${hostname} exec "nc -z localhost %p"
        '';
      };
      "${user}@${hostname}.tailnet" = {
        inherit hostname user port extraOptions;
        match = ''
          user ${user} host ${hostname} exec "nc -z localhost %p"
        '';
      };
    };
}
