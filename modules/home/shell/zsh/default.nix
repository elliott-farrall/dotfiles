{ lib
, config
, ...
}:

let
  cfg = config.shell;
  enable = cfg == "zsh";
in
{
  config = lib.mkIf enable {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
