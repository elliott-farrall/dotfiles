{ pkgs
, ...
}:

{
  users.users.elliott = {
    isNormalUser = true;
    uid = 1000;
    description = "Elliott";
    hashedPassword = "$6$oGzE.WsebpKGq6EL$H8jCPwUWgtG/YIsNBl1DTYuHBTUFiGWsXwQhUvHUuIT0DzL77esFfuH1oT6LdCNvCn.H2IpoKE3uP0h0.BIE01";
    extraGroups = [ "networkmanager" "wheel" "docker" "openrazer" "adbusers" ];
    shell = pkgs.zsh;
  };
}
