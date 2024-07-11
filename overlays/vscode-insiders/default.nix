{ ...
}:

final: prev:
{
  vscode = prev.vscode-insiders.overrideAttrs (attrs: {
    commandLineArgs = "--ozone-platform=wayland";
    postInstall = (attrs.postInstall or "") + ''
      ln -s $out/bin/code-insiders $out/bin/code
      wrapProgram "$out/bin/code" --unset NIXOS_OZONE_WL
    '';
  });
}
