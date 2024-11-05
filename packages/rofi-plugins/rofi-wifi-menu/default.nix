{ lib
, inputs
, stdenv
, makeWrapper
, libnotify
, rofi-wayland-unwrapped
}:

stdenv.mkDerivation {
  pname = "rofi-wifi-menu";
  version = inputs.rofi-wifi-menu.rev;

  src = inputs.rofi-wifi-menu;

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
    license = licenses.unfree;
    # maintainers = with maintainers; [ ];
    mainProgram = "rofi-wifi-menu";
    platforms = platforms.all;
  };
}
