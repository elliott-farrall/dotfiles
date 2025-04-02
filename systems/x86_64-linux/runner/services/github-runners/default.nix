{ pkgs
, config
, ...
}:

{
  age.secrets."dotfiles/token".file = ./repos/dotfiles.age;

  services.github-nix-ci = {
    personalRunners."elliott-farrall/dotfiles" = {
      tokenFile = config.age.secrets."dotfiles/token".path;
      num = 3;
    };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      gh
    ];
  };
}
