{ config
, lib
, pkgs
, ...
}:

{
  age.secrets.github-pat = {
    file = ./github-pat.age;
  };

  home.activation.github-pat = lib.hm.dag.entryAfter [ "linkGeneration" "agenix" ] /*sh*/''
    secret=$(cat "${config.age.secrets.github-pat.path}")
    configFile=${config.xdg.configHome}/nix/nix.conf

    run ${pkgs.gnused}/bin/sed -i "s#@github-pat@#$secret#" "$configFile"
  '';

  nix.settings.access-tokens = "github.com=@github-pat@";
  xdg.configFile."nix/nix.conf".force = true;
}
