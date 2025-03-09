{ pkgs
, ...
}:

{
  # programs.goldwarden = {
  #   enable = true;
  #   useSshAgent = true;
  # };

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = [
    pkgs.libsecret
    pkgs.bitwarden
  ];
}
