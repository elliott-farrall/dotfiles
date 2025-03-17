{ lib
, buildNpmPackage
, fetchFromGitHub
, python3Packages
, electron
}:

buildNpmPackage rec {
  pname = "wolfram-js-frontend";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "JerryI";
    repo = "wolfram-js-frontend";
    rev = "v${version}";
    hash = "sha256-bwVhyLfWDh3Pyli8LF0oHn2BOxl2w7G9olg6YGqZNlg=";
  };

  patches = [
    ./config_path.patch
    ./dmg-platform.patch
  ];

  npmDepsHash = "sha256-adjryd9sKITWx2CWPR5ebyIWDKjUgx/HeQaY5cRry9A=";

  nativeBuildInputs = [
    python3Packages.pip
    python3Packages.setuptools
    electron
  ];

  dontNpmBuild = true;

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
  };

  postInstall = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/lib/node_modules/wljs-notebook/Electron/main.js
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
