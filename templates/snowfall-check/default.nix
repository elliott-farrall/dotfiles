{ lib
, inputs
, namespace
, pkgs
, ...
}:

pkgs.runCommand "my-check" { src = ./.; } ''
  # ...
''
