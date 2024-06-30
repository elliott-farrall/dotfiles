{ lib
, ...
}:

{
  users.users.greeter = {
    isSystemUser = lib.mkForce false;
    isNormalUser = true;
  };
}
