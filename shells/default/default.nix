{ inputs
, pkgs
, system
, ...
}:

let
  inherit (pkgs.devshell) mkShell;
in
mkShell {
  devshell = {
    name = "dotfiles";
    startup = {
      pre-commit.text = inputs.self.checks.${system}.pre-commit.shellHook;
    };
    packages = with pkgs; [ act ];
  };
  commands = [
    {
      name = "flash";
      help = "flash an iso to a device";
      command = "${pkgs.pv}/bin/pv $1 | sudo dd of=$2";
    }
    {
      name = "plant";
      help = "installs a system";
      command = "shells/default/plant.py $@";
    }
    {
      name = "water";
      help = "updates a system";
      command = "nixos-rebuild --flake .#$1 --target-host root@$1 switch";
    }
  ];
}
