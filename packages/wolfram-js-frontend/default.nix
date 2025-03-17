{ lib
, stdenv
, fetchzip
, makeWrapper
, glib
, ffmpeg
, nss
, nspr
, dbus
, atk
, cups
, libdrm
, gtk3
, pango
, cairo
, xorg
, libgbm
, expat
, libxkbcommon
, alsa-lib
, libuv
, libGL
}:

stdenv.mkDerivation rec {
  pname = "wolfram-js-frontend";
  version = "2.7.0";

  src = fetchzip {
    url = "https://github.com/JerryI/wolfram-js-frontend/releases/download/v${version}/wljs-notebook-${version}-x64-gnulinux.zip";
    hash = "sha256-dvJ9P4+Ym7seAS0gn+BINlsL4+OsWqOSWTyYSDoHAxs=";
    stripRoot = false;
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    makeWrapper $src/wljs-notebook $out/bin/wolfram-js-frontend \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ glib ffmpeg nss nspr dbus atk cups libdrm gtk3 pango cairo xorg.libX11 xorg.libXcomposite xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXrandr libgbm expat xorg.libxcb libxkbcommon alsa-lib libuv libGL ]}"

    runHook postInstall
  '';

  meta = {
    description = "Freeware notebook environment for Wolfram Language written in Javascript";
    homepage = "https://github.com/JerryI/wolfram-js-frontend";
    license = lib.licenses.gpl3Only;
    # maintainers = with lib.maintainers; [ ];
    mainProgram = "wolfram-js-frontend";
    platforms = lib.platforms.all;
  };
}
