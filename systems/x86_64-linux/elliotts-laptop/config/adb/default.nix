{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    heimdall
  ];

  programs.adb.enable = true;
}
