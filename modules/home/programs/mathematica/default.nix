{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.mathematica;
  inherit (cfg) enable;
in
{
  options = {
    programs.mathematica.enable = lib.mkEnableOption "Mathematica";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      internal.wolfram-js-frontend
      wolfram-engine
    ];

    home.file.".WolframEngine/SystemFiles/LibraryResources/Linux-x86-64".source = lib.makeLibraryPath [ pkgs.libuv ];
    home.file.".WolframEngine/Kernel/init.m".text = ''
      (** User Mathematica initialization file **)
      LibraryLoad["libuv"]
    '';
  };
}
