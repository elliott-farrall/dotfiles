{ config
, ...
}:

{
  programs.zsh = {
    enable = true;
    history.path = "${config.xdg.stateHome}/zsh/history";
    completionInit = ''
      [ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
      autoload -U compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
    '';
    syntaxHighlighting.enable = true;
  };
}
