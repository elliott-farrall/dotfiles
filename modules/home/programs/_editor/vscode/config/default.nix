{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = (cfg == "vscode") || (cfg == "vscode-insiders");

  inherit (lib.internal) capitalise;

  inherit (config.catppuccin) flavour accent;
in
{
  config = lib.mkIf enable {
    programs.vscode.profiles.default.userSettings = {
      "update.mode" = "none";

      /* -------------------------------- Interface ------------------------------- */

      "window.customTitleBarVisibility" = "auto";
      "window.titleBarStyle" = "native";
      "window.commandCenter" = false;
      "workbench.layoutControl.enabled" = false;

      "workbench.startupEditor" = "none";
      "editor.minimap.enabled" = false;

      /* ---------------------------------- Theme --------------------------------- */

      "explorer.compactFolders" = false;

      "workbench.colorTheme" = lib.mkForce "Catppuccin ${capitalise flavour}";
      "catppuccin.accentColor" = accent;
      "catppuccin.customUIColors" = {
        "all" = {
          "statusBar.foreground" = "accent";
        };
      };

      "workbench.iconTheme" = "catppuccin-${flavour}";
      "catppuccin-icons.specificFolders" = true;
      "catppuccin-icons.hidesExplorerArrows" = true;
      "catppuccin-icons.associations.folders" = {
        "lib" = "folder_functions";
        "checks" = "folder_tests";
        "overlays" = "folder_middleware";
        "shells" = "folder_command";
        "systems" = "folder_config";
        "homes" = "folder_config";
      };

      /* --------------------------------- Editor --------------------------------- */

      "files.autoSave" = "afterDelay";

      "github.copilot.editor.enableAutoCompletions" = true;

      "autoscroll.autoEnableForLogs" = true;
      "autoscroll.keepLastLineInCenter" = false;

      "diffEditor.ignoreTrimWhitespace" = false;

      /* ----------------------------------- Git ---------------------------------- */

      "git.defaultCloneDirectory" = config.xdg.userDirs.extraConfig.XDG_REPO_DIR;
      "githubRepositoryManager.alwaysCloneToDefaultDirectory" = true;

      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.allowForcePush" = true;
      "git.replaceTagsWhenPull" = true;
      "git.ignoreRebaseWarning" = true;

      "git-graph.showStatusBarItem" = false;

      "conventionalCommits.autoCommit" = false;
      "conventionalCommits.promptScopes" = false;
      "conventionalCommits.gitmoji" = false;
      "conventionalCommits.promptFooter" = false;
      "conventionalCommits.promptBody" = false;

      /* ----------------------------------- Nix ---------------------------------- */

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.formatterPath" = [ "nix" "fmt" "--" "-" ];
      "nix.serverSettings" = {
        "nil" = {
          "diagnostics" = {
            "ignored" = [ "unused_binding" "unused_with" ];
          };
        };
      };

      /* ---------------------------------- LaTeX --------------------------------- */

      "latex-workshop.latex.autoBuild.run" = "onSave";
      "latex-workshop.latex.autoClean.run" = "onSucceeded";

      "ltex.language" = "en-GB";
      "zotero.latexCommand" = "cite";

      /* --------------------------------- Python --------------------------------- */

      "python.terminal.activateEnvironment" = false;
      "python.analysis.typeCheckingMode" = "off";

      "autoDocstring.startOnNewLine" = true;
      "autoDocstring.docstringFormat" = "pep257";

      "[python]" = {
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
    };
  };
}
