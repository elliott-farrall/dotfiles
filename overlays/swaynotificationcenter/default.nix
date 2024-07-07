{ ...
}:

final: prev:
{
  swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      # ./systemd.patch # https://github.com/ErikReider/SwayNotificationCenter/discussions/400
    ];
  });
}
