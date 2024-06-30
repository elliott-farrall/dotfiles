{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation {
  pname = "rofi-network-manager";
  version = "unstable-2023-06-25";

  src = fetchFromGitHub {
    owner = "P3rf";
    repo = "rofi-network-manager";
    rev = "19a3780fa3ed072482ac64a4e73167d94b70446b";
    hash = "sha256-sK4q+i6wfg9k/Zjszy4Jf0Yy7dwaDebTV39Fcd3/cQ0=";
  };

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
