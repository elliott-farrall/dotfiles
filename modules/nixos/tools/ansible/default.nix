{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.tools.ansible;
  inherit (cfg) enable;
in
{
  options = {
    tools.ansible.enable = lib.mkEnableOption "Ansible";
  };

  config = lib.mkIf enable {
    environment.systemPackages = with pkgs; [
      ansible
      python3
    ];

    environment.etc."ansible/hosts".text = ''
      [linux]
      broad
      lima

      [linux:vars]
      ansible_python_interpreter=auto_silent
    '';

    environment.variables = {
      PYTHONWARNINGS = "ignore::UserWarning"; # https://github.com/ansible/ansible/issues/52598
    };
  };
}
