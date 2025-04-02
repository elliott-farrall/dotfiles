{ ...
}:

_final: prev:
{
  renovate = prev.renovate.overrideAttrs (_attrs: {
    patches = prev.patches or [ ] ++ [
      (prev.fetchpatch {
        url = "https://github.com/renovatebot/renovate/pull/33991.diff";
        hash = "sha256-6ME048IiptweOkJhnK9QvQqfJ6QaXWX23SlY5TAmsFE=";
      })
    ];
  });
}
