{ lib
, inputs
, stdenv
, makeWrapper
, python3
, pulseaudio
}:

stdenv.mkDerivation {
  pname = "rofi-mixer";
  version = inputs.rofi-mixer.rev;

  src = inputs.rofi-mixer;

  sourceRoot = "source/src";

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
