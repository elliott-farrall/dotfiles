{ pkgs
, ...
}:

{
  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
}
