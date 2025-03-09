{ lib
, ...
}:

_final: prev:
{
  keyguard = prev.symlinkJoin {
    name = "keyguard";
    paths = [ prev.keyguard ];
    buildInputs = [ prev.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/Keyguard --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ prev.libGL ]}"
    '';
  };
}
