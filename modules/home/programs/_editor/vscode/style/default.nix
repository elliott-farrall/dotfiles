{ lib
, config
, ...
}:

let
  cfg = config.editor;
  enable = (cfg == "vscode") || (cfg == "vscode-insiders");
in
{
  config = lib.mkIf enable {
    catppuccin.vscode = {
      enable = true;
      settings = {
        boldKeywords = true;
        italicComments = true;
        italicKeywords = true;
        colorOverrides = { };
        customUIColors = { };
        workbenchMode = "default";
        bracketMode = "rainbow";
        extraBordersEnabled = false;
      };
    };
  };
}
