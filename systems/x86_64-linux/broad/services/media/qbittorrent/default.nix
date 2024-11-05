{ pkgs
, ...
}:

{
  environment.etc."broad/qbittorrent/config.conf".source = ./config.conf;

  environment.etc."broad/qbittorrent/vuetorrent" = {
    source = pkgs.fetchzip {
      url = "https://github.com/VueTorrent/VueTorrent/releases/download/v2.12.0/vuetorrent.zip";
      hash = "sha256-JN9jbslu2B1h5WWtge2vR59ZGytRYuRP7njOBdu14Tk=";
    };
  };
}
