{ ...
}:

#FIXME - Temporary fix for the rmview package

_final: prev:
{
  rmview = prev.rmview.overrideAttrs (attrs: {
    src = prev.fetchFromGitHub {
      owner = "bordaigorl";
      repo = attrs.pname;
      rev = "d171b657e40a50bfe38dfd90cd0d861cf61de60e";
      sha256 = "sha256-Ai8KEtckmdQ0F4q5JHUuKpUUAVL4tNLXlWNfft6aGd0=";
    };
  });
}
