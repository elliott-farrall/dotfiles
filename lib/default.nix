{ lib
, ...
}:

{

  # Makes systemd unit name for mount
  #
  # path: string          path to mount
  #
  # returns: string       unit name
  mkMountName = path: lib.strings.removePrefix "-" "${builtins.replaceStrings [ "/" ] [ "-" ] path}";

}
