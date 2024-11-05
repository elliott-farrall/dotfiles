{ lib
, ...
}:

{
  imports = [
    ../../x86_64-linux/broad
  ];

  networking.hostName = lib.mkForce "broad";

  virtualisation = {
    cores = 4;
    memorySize = 6 * 1024;

    diskSize = 50 * 1024;
    sharedDirectories."storage" = {
      source = "/home/elliott/NixVM";
      target = "/mnt/storage";
    };

    forwardPorts = [
      { from = "host"; host.port = 2222; guest.port = 22; } # ssh
      { from = "host"; host.port = 80; guest.port = 80; } # web
      { from = "host"; host.port = 443; guest.port = 443; } # websecure
      { from = "host"; host.port = 8443; guest.port = 8443; } # auth
    ];
  };

  # boot.growPartition = true;
}
