{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, python3
, pulseaudio
}:

stdenv.mkDerivation rec {
  pname = "rofi-mixer";
  version = "unstable-2022-10-12";

  src = fetchFromGitHub {
    owner = "joshpetit";
    repo = "rofi-mixer";
    rev = "9944bf9dbea915f0ecaf3163fff94f5f6d53a88c";
    hash = "sha256-hBjgGLDK10AY7oo2NP3gYRbNxjR2LFsZD5qCr7PgdXI=";
  };

  sourceRoot = "${src.name}/src";

  installPhase = ''
    install -Dm755 rofi-mixer.py $out/bin/rofi-mixer.py
    wrapProgram $out/bin/rofi-mixer.py --prefix PATH : ${lib.makeBinPath [ pulseaudio ]}

    install -Dm755 rofi-mixer $out/bin/rofi-mixer
  '';

  buildInputs = [ python3 pulseaudio ];
  nativeBuildInputs = [ makeWrapper ];

  meta = with lib; {
    description = "A sound device mixer made with rofi";
    homepage = "https://github.com/joshpetit/rofi-mixer";
    license = licenses.mit;
    # maintainers = with maintainers; [ ];
    mainProgram = "rofi-mixer";
    platforms = platforms.all;
  };
}
