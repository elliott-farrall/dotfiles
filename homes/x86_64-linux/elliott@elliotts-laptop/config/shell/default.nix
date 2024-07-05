{ ...
}:

{
  imports = [
    ./bash
    ./zsh
  ];

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[[♥](green) ❯](maroon)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
    };
  };
}
