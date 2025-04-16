{ ...
}:

#TODO - Better handling of unwanted desktop items

{
  home.extraProfileCommands = ''
    rm -f $out/share/applications/kvantummanager.desktop
  '';
}
