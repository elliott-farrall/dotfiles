{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.editor;
  enable = (cfg == "vscode") || (cfg == "vscode-insiders");

  name = lib.strings.removePrefix "vs" cfg;

  inherit (lib.internal) mkDefaultApplications;

  package = pkgs.${cfg}.overrideAttrs (attrs: {
    desktopItems = [
      ((lib.lists.findFirst (item: item.name == "${name}.desktop") null attrs.desktopItems).override {
        desktopName = "VS Code";
      })
      ((lib.lists.findFirst (item: item.name == "${name}-url-handler.desktop") null attrs.desktopItems).override {
        desktopName = "VS Code URL Handler";
      })
    ];
    postInstall =
      if config.wayland.windowManager.hyprland.enable then ''
        wrapProgram $out/bin/${name} \
          --set ELECTRON_OZONE_PLATFORM_HINT auto
      '' else null;
  });
in
{
  config = lib.mkIf enable {
    programs.vscode = {
      enable = true;
      inherit package;
      mutableExtensionsDir = false;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        extensions = (pkgs.nix4vscode.forVscode [
          "github.copilot"
          "github.copilot-chat"
        ]) ++ (with pkgs.vscode-marketplace; [
          # Core
          ms-vscode.remote-explorer
          ms-vscode.remote-server
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vscode-remote.remote-containers
          ms-vscode.remote-repositories
          ms-vscode.azure-repos
          ms-azuretools.vscode-docker
          ms-azuretools.vscode-azureterraform
          ms-kubernetes-tools.vscode-kubernetes-tools
          github.vscode-github-actions
          hashicorp.terraform
          # Environment
          henriquebruno.github-repository-manager
          mhutchie.git-graph
          mkhl.direnv
          # Editor
          vivaxy.vscode-conventional-commits
          exodiusstudios.comment-anchors
          stackbreak.comment-divider
          bierner.markdown-preview-github-styles
          bierner.markdown-checkbox
          bierner.markdown-emoji
          njpwerner.autodocstring
          # Languages
          jnoortheen.nix-ide # Nix
          redhat.vscode-yaml # YAML
          tamasfe.even-better-toml # TOML
          samuelcolvin.jinjahtml # Jinja
          ms-python.python # Python
        ]);
      };
    };

    home.shellAliases = lib.mkIf (cfg == "vscode-insiders") {
      code = "code-insiders";
    };

    home.sessionVariables = {
      EDITOR = "${name} -w";
      VISUAL = "${name} -w";
    };

    xdg.mimeApps.defaultApplications = mkDefaultApplications "${name}.desktop" [
      "text/plain"
      "text/html"
      "text/css"
      "text/javascript"
      "application/javascript"
      "application/json"
      "application/xml"
      "application/x-yaml"
      "application/x-python"
      "application/x-php"
      "application/x-ruby"
      "application/x-perl"
      "application/x-shellscript"
      "application/x-csrc"
      "application/x-c++src"
      "application/x-java"
      "application/sql"
    ] // {
      "application/x-desktop" = "${name}-url-handler.desktop";
    };
  };
}
