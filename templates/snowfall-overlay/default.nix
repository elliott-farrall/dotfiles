{ channels
, namespace
, inputs
, ...
}:

_final: prev:
{
  package = prev.package.overrideAttrs (_attrs: rec {
    # ...
  });
}
