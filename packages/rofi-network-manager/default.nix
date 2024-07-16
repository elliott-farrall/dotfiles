{ lib
, stdenv
, fetchFromGitHub

, sources ? import ../nix/sources.nix
}:

stdenv.mkDerivation {
  pname = "rofi-network-manager";
  version = "unstable-2023-06-05";

  src = fetchFromGitHub { inherit (sources.rofi-network-manager) owner repo rev sha256; };

  installPhase = ''
    install -Dm755 rofi-network-manager.sh $out/bin/rofi-network-manager

    mv rofi-network-manager.rasi $out/bin/rofi-network-manager.rasi
    mv rofi-network-manager.conf $out/bin/rofi-network-manager.conf
  '';

  patches = [ ./no-theme.patch ];

  meta = with lib; {
    description = "A manager for network connections using bash, rofi, nmcli,qrencode";
    homepage = "https://github.com/P3rf/rofi-network-manager/tree/master";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "rofi-network-manager";
    platforms = platforms.all;
  };
}
