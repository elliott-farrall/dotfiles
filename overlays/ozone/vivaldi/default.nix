{ ...
}:

final: prev:
{
  obsidian = prev.obsidian.overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
      wrapProgram $out/bin/obsidian \
        --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}"
    '';
  });
}
