{ ...
}:

{
  home-manager = {
    useUserPackages = true;
    backupFileExtension = "old";
  };
  # https://github.com/nix-community/home-manager/pull/5158#issuecomment-2043764620
  environment.pathsToLink = [ "/share/xdg-desktop-portal" ]; #TODO - Look into alternative to path link
}
