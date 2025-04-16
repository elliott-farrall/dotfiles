{ ...
}:

#TODO - Add WolframScript overlay

_final: prev:
{
  mathematica = prev.mathematica.overrideAttrs (_attrs: rec {
    name = "mathematica-${version}";
    version = "14.0.0";
    installer = "Mathematica_${version}_LINUX.sh";

    src = prev.fetchurl {
      url = "https://dotfiles.beannet.io/${installer}";
      sha256 = "sha256-NzMhGQZq6o6V4UdtJxUH/yyP2s7wjTR86SRA7lW7JfI=";
    };
  });
}
