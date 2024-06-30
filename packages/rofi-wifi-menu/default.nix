{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, libnotify
, rofi-wayland-unwrapped
}:

stdenv.mkDerivation {
  pname = "rofi-wifi-menu";
  version = "unstable-2023-11-23";

  src = fetchFromGitHub {
    owner = "ericmurphyxyz";
    repo = "rofi-wifi-menu";
    rev = "d6debde6e302f68d8235ced690d12719124ff18e";
    hash = "sha256-H+vBRdGcSDMKGLHhPB7imV148O8GRTMj1tZ+PLQUVG4=";
  };

  installPhase = ''
    runHook preInstall

    install -D --target-directory=$out/bin/ ./rofi-wifi-menu.sh

    mv $out/bin/rofi-wifi-menu.sh $out/bin/rofi-wifi-menu

    wrapProgram $out/bin/rofi-wifi-menu \
      --prefix PATH ":" ${lib.makeBinPath [ rofi-wayland-unwrapped libnotify ]}

    runHook postInstall
  '';

  patches = [ ./fix.patch ];

  nativeBuildInputs = [ makeWrapper ];

  meta = with lib; {
    description = "A bash script using nmcli and rofi to make a wifi menu for your favorite window manager";
    homepage = "https://github.com/ericmurphyxyz/rofi-wifi-menu";
    license = licenses.unfree; # FIXME: nix-init did not find a license
    # maintainers = with maintainers; [ ];
    mainProgram = "rofi-wifi-menu";
    platforms = platforms.all;
  };
}
