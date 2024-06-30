{ config
, lib
, pkgs
, ...
}:

{

  /* -------------------------------------------------------------------------- */
  /*                                  Packages                                  */
  /* -------------------------------------------------------------------------- */

  home.packages = with pkgs; [ prismlauncher ];

  /* -------------------------------------------------------------------------- */
  /*                                   Desktop                                  */
  /* -------------------------------------------------------------------------- */

  xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    name = "Minecraft";
    comment = "A custom launcher for Minecraft that allows you to easily manage multiple installations of Minecraft at once.";
    icon = "${pkgs.minecraft.overrideAttrs(_: _: { meta.broken = false; })}/share/icons/hicolor/symbolic/apps/minecraft-launcher.svg";
    noDisplay = false;

    exec = " ${pkgs.prismlauncher}/bin/prismlauncher %U";
    type = "Application";
    terminal = false;

    categories = [ "Game" "ActionGame" "AdventureGame" "Simulation" ];
    mimeType = [ "application/zip" "application/x-modrinth-modpack+zip" "x-scheme-handler/curseforge" ];
  };

  /* -------------------------------------------------------------------------- */
  /*                                Configuration                               */
  /* -------------------------------------------------------------------------- */

  home.activation.minecraftLinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -e ${config.home.homeDirectory}/.java ]; then
      run rm -r ${config.home.homeDirectory}/.java
    fi
    if [ ! -e ${config.xdg.configHome}/java ]; then
      run mkdir -p ${config.xdg.configHome}/java
    fi
    run ln -s ${config.xdg.configHome}/java ${config.home.homeDirectory}/.java

    if [ -e ${config.home.homeDirectory}/.minecraft ]; then
      run rm -r ${config.home.homeDirectory}/.minecraft
    fi
    if [ ! -e ${config.xdg.dataHome}/minecraft ]; then
      run mkdir -p ${config.xdg.dataHome}/minecraft
    fi
    run ln -s ${config.xdg.dataHome}/minecraft ${config.home.homeDirectory}/.minecraft

    if [ -e ${config.home.homeDirectory}/.mputils ]; then
      run rm -r ${config.home.homeDirectory}/.mputils
    fi
    if [ ! -e ${config.xdg.dataHome}/mputils ]; then
      run mkdir -p ${config.xdg.dataHome}/mputils
    fi
    run ln -s ${config.xdg.dataHome}/mputils ${config.home.homeDirectory}/.mputils
  '';
}
