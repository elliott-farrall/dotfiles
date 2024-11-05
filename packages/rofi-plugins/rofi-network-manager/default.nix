{ lib
, inputs
, stdenv
}:

stdenv.mkDerivation {
  pname = "rofi-network-manager";
  version = inputs.rofi-network-manager.rev;

  src = inputs.rofi-network-manager;

  sourceRoot = "source/src";

  installPhase = ''
    install -Dm755 ronema $out/bin/ronema

    mv ronema.conf $out/bin/ronema.conf
  '';

  meta = with lib; {
    description = "A manager for network connections using bash, rofi, nmcli,qrencode";
    homepage = "https://github.com/P3rf/rofi-network-manager/tree/master";
    license = licenses.mit;
    # maintainers = with maintainers; [ ];
    mainProgram = "rofi-network-manager";
    platforms = platforms.all;
  };
}
