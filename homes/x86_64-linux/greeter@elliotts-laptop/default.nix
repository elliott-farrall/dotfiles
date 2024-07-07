{ osConfig
, pkgs
, ...
}:

{
  home.stateVersion = "23.05";

  /* ---------------------------------- Theme --------------------------------- */

  inherit (osConfig) catnerd;
}
