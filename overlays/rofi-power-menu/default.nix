{ ...
}:

final: prev:
{
  rofi-power-menu = prev.rofi-power-menu.overrideAttrs (attrs: {
    patches = attrs.patches or [ ] ++ [
      ./hyprlock.patch
    ];
  });
}
