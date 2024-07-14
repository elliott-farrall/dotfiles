{ ...
}:

final: prev:
{
  libtsm = prev.libtsm.overrideAttrs (attrs: rec {
    version = "custom";

    src = prev.fetchFromGitHub {
      owner = "Aetf";
      repo = "libtsm";
      rev = "69922bd";
      sha256 = "sha256-Rug3OWSbbiIivItULPNNptClIZ/PrXdQeUypAAxrUY8=";
    };
  });
}
