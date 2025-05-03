{ lib
, pkgs
, inputs
, format
, host
, ...
}:

let
  enable = format == "linux";

  inherit (inputs.self.nixosConfigurations.runner.config.services.ntfy-sh) settings;
  ntfy-url = "${settings.base-url}${settings.listen-http}";
  ntfy-topic = "system";
in
{
  config = lib.mkIf enable {
    services.comin = {
      enable = false; #TODO - Come up with better auto update solution
      remotes = [
        {
          name = "origin";
          url = "https://github.com/elliott-farrall/dotfiles";
          branches.main.name = "main";
        }
      ];
    };

    system.activationScripts.notify.text = ''
      ${lib.getExe pkgs.curl} \
        -H "Title: System Activation (${host})" \
        -d "Successfully activated ${host}" \
      ${ntfy-url}/${ntfy-topic} > /dev/null 2>&1
    '';
  };
}
