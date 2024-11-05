{ config
, lib
, host
, ...
}:

let
  cfg = config.networking.access;
  inherit (cfg) enable;
in
{
  options = {
    networking.access.enable = lib.mkEnableOption "external access" // { default = true; };
  };

  config = lib.mkIf enable {
    age.secrets = {
      tailscale.file = ./tailscale.age;
    };

    # SSH
    services.openssh.enable = true;
    # TailScale
    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale.path;
      extraUpFlags = [ "--ssh" "--hostname" host ];
    };
    # VSCode Server
    programs.nix-ld.enable = true;
  };
}
