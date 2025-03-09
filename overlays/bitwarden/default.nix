{ inputs
, ...
}:

_final: prev:
{
  bitwarden = inputs.nixpkgs-bitwarden.legacyPackages.${prev.system}.bitwarden.overrideAttrs (attrs: {
    preBuild = (attrs.preBuild or "") + ''
      pushd apps/desktop/desktop_native/proxy
      cargo build -Z unstable-options --artifact-dir ../dist -p desktop_proxy
      mv ../dist/desktop_proxy ../dist/desktop_proxy.linux-x64
      popd
    '';
    postInstall = (attrs.postInstall or "") + ''
      pushd apps/desktop/desktop_native/dist
      cp desktop_proxy.linux-x64 $out/bin/desktop_proxy
      popd
    '';
  });
}
