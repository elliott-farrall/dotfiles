{ ...
}:

{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/elliott-farrall/dotfiles";
        branches.main.name = "main";
      }
    ];
  };
}
