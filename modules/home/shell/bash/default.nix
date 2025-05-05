{ lib
, config
, ...
}:

let
  cfg = config.shell;
  enable = cfg == "bash";
in
{
  config = lib.mkIf enable {
    programs.bash.enable = true;
  };
}
