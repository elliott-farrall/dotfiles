{ ...
}:

#TODO - Better handling of unwanted desktop items

{
  environment.extraSetup = ''
    rm -f $out/share/applications/cups.desktop
    rm -f $out/share/applications/qt5ct.desktop
    rm -f $out/share/applications/qt6ct.desktop
  '';
}
