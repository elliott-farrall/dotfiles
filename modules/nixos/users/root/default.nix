{ lib
, ...
}:

{
  users.users.root = {
    # There is a current bug in NixOS that prevents /etc/shadow
    # from being updated when the password is changed.
    #   https://github.com/NixOS/nixpkgs/issues/99433
    # To force the password to update run:
    #   sudo rm /etc/shadow
    # and restart the system.

    hashedPassword = lib.strings.fileContents ./password.hash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUjxl1444qMm7/Xp2MTZIoU31m1j/UsThn5a3ql1lD2"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCN/Yz6cpeYKkinW0eVRZxMKwYWkgtGGCM5XTg3MonpTwnsFWloib90GdYnidFfRtRo14tLc166FJ657oPeomgmnpkTWqd0kCuezL4775gpse/1o8AVwgEAYMMACnYqmo+hFls5Y7ZiZ+GYO34W2UUjrZFu9V/OuFOooydcSSNFmobakhxdCyJhurJ5x77xhnBqo3+tgvsHJjv5l4m2SLB5ea5ds/luGequJaXbVn9p5rjMsej0dPF7a46u6RkyQD98442gKzCSGOW0fW/mKaNPtsks57BuPiVeJT2lMHqMRxpYIxx4SeG48jTfdZICkXk9el0V9DLciYS+2vG+kSaAUX8FdbRIblxLJYuWBWL6joFF+sKqJJS/2y9JdJ3qYWOxOjFpqTaZvHzKo9t6XQhB4PD1N7EbvEwq6+XtVde2RB3TOAUAhkiBlbw/svql6U//IVDq6mgwIAhfIRbi9X2BMfiPhOrhsz9TPa047EjoSJHjb9Kr1ItEkcVRwfe8AeSTDb0fs5leMP/aFrKS1D1hqaocABkq4+TuqwtwSpkRzt5v21cZ4gaAG61Qq3Jhe8QETZjGPrGdq1R8AZxo9lT4Rx9OQyixj6tYJ6HfFlgKLq8Z4xfWmmEgn251ySOORGBiNSYBpF2ne/rwzdtZnxAZd/cwI1LtuNw1vb1JC0Gilw=="
    ];
  };
}
