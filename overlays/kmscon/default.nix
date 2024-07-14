{ ...
}:

final: prev:
{
  kmscon = prev.kmscon.overrideAttrs (attrs: rec {
    version = "custom";

    src = prev.fetchFromGitHub {
      owner = "Aetf";
      repo = "kmscon";
      rev = "32e83aa";
      sha256 = "sha256-ZNHy2MdloK1BHbSffiu9o4oIORAqwsT1t6VdvVH2+eg=";
    };

    buildInputs = attrs.buildInputs ++ (with prev; [
      check
    ]);

    patches = [ ./0001-modified-systemdunitdir.patch ];

    mesonFlags = [
      "-Ddocs=disabled"

      # "-Dvideo_fbdev=disabled"
      # "-Dvideo_drm2d=enabled"
      # "-Dvideo_drm3d=disabled"

      # "-Drenderer_bbulk=disabled"
      # "-Drenderer_gltex=disabled"
      # "-Drenderer_pixman=enabled"

      # "-Dfont_unifont=disabled"
      # "-Dfont_pango=enabled"
    ];
  });
}
