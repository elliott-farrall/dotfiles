{ lib
, buildNpmPackage
, fetchFromGitHub
, fetchzip
, makeWrapper
, electron
, python312
, libGL
, polkit
, makeDesktopItem
, copyDesktopItems
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

  npmDepsHash = "sha256-spEzasCBhBUOUW1g8rIxy0xmRdVdexmq5LS8K/JS/Og=";
  npmFlags = [ "--force" ]; # ignore platform incompatibility for some deps

  nativeBuildInputs = [
    (python312.withPackages (ps: with ps; [ pip setuptools ]))
    makeWrapper
    copyDesktopItems
  ];

  env.ELECTRON_SKIP_BINARY_DOWNLOAD = true;

  buildPhase = ''
    runHook preBuild

    npm exec electron-builder -- \
      --dir \
      -c.electronDist=${electron.dist} \
      -c.electronVersion=${electron.version}

    runHook postBuild
  '';

  installPhase =
    let
      bundle = fetchzip {
        url = "https://github.com/JerryI/wolfram-js-frontend/releases/download/v${version}/wljs-notebook-${version}-arm64-gnulinux.zip";
        hash = "sha256-LqmHFCxQzwWlfuLcxZo5iXXAob4aZl4uWh7P+pffpHU=";
        stripRoot = false;
      };
    in
    ''
      runHook preInstall

      mkdir -p $out
      cp -r dist/*-unpacked $out/dist

      cd ${bundle}/resources/app/bundle
      find . -type f -exec install -Dm 755 "{}" "$out/dist/resources/app/bundle/{}" \;

      runHook postInstall
    '';

  postInstall = ''
    for sz in 512; do
      mkdir -p $out/share/icons/hicolor/''${sz}x''${sz}/apps
      cp $src/Electron/build/file/''${sz}x''${sz}.png $out/share/icons/hicolor/''${sz}x''${sz}/apps/wljs-notebook.png
    done
  '';

  postFixup = ''
    makeWrapper $out/dist/wljs-notebook $out/bin/wljs-notebook \
      --add-flags "--no-sandbox" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libGL ]}"

    substituteInPlace $out/dist/resources/app/node_modules/sudo-prompt/index.js \
      --replace "/usr/bin/pkexec" "${polkit}/bin/pkexec"
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "wljs-notebook";
      icon = "wljs-notebook";
      exec = "wljs-notebook %f";
      desktopName = "Wolfram";
      categories = [ "Development" ];
    })
  ];

  meta = {
    description = "Freeware notebook environment for Wolfram Language written in Javascript";
    homepage = "https://github.com/JerryI/wolfram-js-frontend";
    license = lib.licenses.gpl3Only;
    # maintainers = with lib.maintainers; [ ];
    mainProgram = "wljs-notebook";
    platforms = lib.platforms.all;
  };
}
