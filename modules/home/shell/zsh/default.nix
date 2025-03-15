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
      dotDir = "${lib.strings.removePrefix config.home.homeDirectory config.xdg.configHome}/zsh";
      history.path = "${config.xdg.stateHome}/zsh/history";
      completionInit = ''
        [ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
        autoload -U compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
      '';
      syntaxHighlighting.enable = true;
    };
  };
}
