{ lib
, ...
}:

{
  # Makes systemd unit name for mount
  # path: string
  # returns: string
  mkMountName = path: lib.strings.removePrefix "-" "${builtins.replaceStrings [ "/" ] [ "-" ] path}";
}
