{ config
, pkgs
, ...
}:

let
  pubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLh0wL2CDMQL0iVtyC2V+RPNJiWoO3oLBsjgYW8fmgt";
in
{
  age.secrets = {
    "github/auth".file = ./auth.age;
    "github/sign".file = ./sign.age;
    "github/sign".path = "${config.home.homeDirectory}/.ssh/keys/github/sign";
  };

  programs.git = {
    enable = true;
    userName = "elliott-farrall";
    userEmail = "108588212+elliott-farrall@users.noreply.github.com";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${pkgs.writeText "allowed_signers" "* ${pubKey}"}";
      user.signingkey = pubKey;
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.ssh.matchBlocks."github.com".identityFile = config.age.secrets."github/auth".path;
}
