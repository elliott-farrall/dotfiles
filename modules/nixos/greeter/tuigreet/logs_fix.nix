{ lib
, config
, ...
}:

#TODO - Is this fix still needed?

let
  cfg = config.greeter;
  enable = cfg == "tuigreet";
in
{
  config = lib.mkIf enable {
    # Fix from https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    # systemd.services.greetd.serviceConfig = {
    #   Type = "idle";
    #   StandardInput = "tty";
    #   StandardOutput = "tty";
    #   StandardError = "journal";
    #   TTYReset = true;
    #   TTYVHangup = true;
    #   TTYVTDisallocate = true;
    # };
  };
}
