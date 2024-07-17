{ ...
}:

final: prev:
{
  vscode-insiders = prev.vscode-insiders.overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
      wrapProgram $out/bin/code-insiders \
        --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}"

      ln -s $out/bin/code-insiders $out/bin/code
    '';
  });
}
