{ sources ? import ../nix/sources.nix
, pkgs
, ...
}:

final: prev:
{
  kmscon = prev.kmscon.overrideAttrs (attrs: {
    version = "unstable-2024--07-15";

    src = pkgs.fetchFromGitHub { inherit (sources.kmscon) owner repo rev sha256; };

    buildInputs = attrs.buildInputs ++ (with pkgs; [
      check
    ]);

    patches = [ ./0001-modified-systemdunitdir.patch ];

    mesonFlags = [
      "-Ddocs=disabled"

      "-Dvideo_fbdev=disabled"
      # "-Dvideo_drm2d=enabled"
      # "-Dvideo_drm3d=enabled"

      # "-Drenderer_bbulk=disabled"
      # "-Drenderer_gltex=disabled"
      # "-Drenderer_pixman=enabled"

      # "-Dfont_unifont=disabled"
      # "-Dfont_pango=enabled"
    ];
  });
}
