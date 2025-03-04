{ pkgs
, ...
}:

{
  age.secrets."dotfiles/token".file = ./repos/dotfiles.age;

  # system.activationScripts.setupAuthorizedKeys = ''
  #   cat /etc/ssh/authorized_keys.d/root >> /root/.ssh/authorized_keys
  # '';

  services.github-nix-ci = {
    # personalRunners."elliott-farrall/dotfiles" = {
    #   tokenFile = config.age.secrets."dotfiles/token".path;
    #   num = 3;
    # };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      gh
    ];
  };
}
