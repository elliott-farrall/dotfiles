let
  hosts = {
    broad = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILIjOvIC8/IqRPyLIPCXdUbjGy9WCqSpBgCwanHANoVo"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZpNf82KHoAvQm0ntmDBbZ5mSNiEK1qHkUnD0eWoGpfz2OjAn2BX2tahPcrx5iaF5qm1lv8LQgshHN61G329BP7Ti6acrn3wMRvi/xlVM+ln6NsWy59P9H4pJWDvwEG9W8SirKZl1nzyUmwFxYA0TSaDlnH2NkKtyLc97Iw3GsIXFAGnaIxWai9PjLMaKnF9ks6S3XVrp6/Lj+wybHPap5kwWzMcpxWafyvC2IdRENk8LtVqjsgle8fi9oYGx9cU1RzdG2opcziW/oqHZdGkG8rKVTBlTkWsa13vv2Z6+/Y/YMEBtRtvJGMeGK195AS9RJhVmZ6QlS/HI76e+bJcDLuy3BpdRN1GCHm5oiiNDE0kugMtYf7yvKfr0bDas/hbSYTncimKceUQ5MO8oxnqzp1FxyOG3nYnBvET7gwaNFMxr2vFWlLymkDMa+FFnLpEddGmiVaJXV1o5JYUrF8cYfhqrOBfyrqmuFwKBKtunko5aaolSu7VduOh77nnUqg2QAw6dni15D7EnJLT0UbEoYMLWsnpka1Ms/RPXYENfNdvweo7snUq0keChu/b5voFeXBeHFznLVETy4ohd40fZHcq4kWUeCZ7aSvFAmY/0snHgsyy3YSuBFzi/vu9rAPk4UgG/p5rJwzA5hmV8jkrdLl1Hcd+wSrDj67ZjghwdFXw=="
    ];
    lima = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgnRcttMN98rmRJEqafrsxvtiGrWT/iGJH6thNE/1wZ"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG7qeZGX5BZiumHNIIdEHmpxtEo41MT8Pi6KNVp7yB1bKwAkNSPlG7VXdLnIK0VqyHugJKJkp/t2MTXH48jwetwbXVckS500yhveRVHdOxk2uOx+CxVy1hXNyVMZCsSXh1/t+B3tIydGnEmNfJekzlKYqJlJOs0+S0o/FOeajHGv8vMyMP1WmDN27X1zuZXAxt5vcxT5iI7dT7VnKmHpwr0xE9k/Rpc6G0EmmQxJflX9P6WebvDmMQmUZvpTBkFtT0B0ZX8+OrQSY1l9k9esu7PelNzTaX6+/xH7Zs1fhMMMZMn2k556jY8f0Dl3b4lBiO67jz5GQohNNY3ohJMX+favL6VrYnJVWKCryH6Qk5FnTqB1UAhGfrNWUx5zOm9G5jTENIoLAErbjMXkmpz3Hf/0ZOD4T/fi0V5asMRA2UB9BYWnGAr5xwuPhRlxZcM8k6FVsh+19H0bsmCyNqeXLZ5tl4xbuyLqK68XjiOP/6BNPJI0Zsjmbj47bogIafRYrLFs/Dctfcx+wked0SJtv/jm0v3XTcStCjnWlCTA90d3ZKMVM4NReCn7zzGE+tgENxVqqWiVZ5MkQGc1/sEbzbX4tf7j6vqS5iEIdswKbKJDbSPcrpWxhLXh/RyvBjanBn6p3otYem0xD/yLTPc0XkanucuLkT/E/rIv+y9Y3rUQ=="
    ];
    runner = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxPF/zdFkxPvNQcdG0J7Kk0c5AI0nDsEW2ldzk8H0O2"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCMUCq8Ej/M1x+Z3EuWzmWj0L0TiKaEWppmZP046hvzD0vkSDcgcWuZzGChemq1vxBQ9UMdip/2104cjqWSdoXDM2XlyRwA5AEXZ08m7U2DSdVi7evGonvR6qBq3E0StqRnwAIY6GrFdUh9VJZjyBfg4Z3B27qDahmng+WEzImE6aHeUSvILCYP9AZ4jlVuQwpiXv19wHByLYd4f4BAduloNFAiShPDl3LQbuy4ObPuW4JcWI3TIcNgXQohY0r6Iglqm2lcs+mgx/iOLTO2zvo/rJCSrVnR2Sg1P9fLdwlCv9rFsAQ/28gcA6gBFTmWgcdQnDjfNOoUyy7eoMwm2o5kV6q20ZyWuRO/U2+05Ly5IkLitAl0ZnSM7h3jgO36qRZfJXRzuVdgLTffynMO+t0kf9TP/GVkyzx28beK5Q07XlkRk5/W6WmC+zEk3AcgCpMhTZ7gHrMAJe3ANyJ47v779v/n6sA5AJiGJHxBrU+k8eYKfrXuAFvs+HGY99hSdvjpeqbrvxfjkQJkCHL5ELnJhpg4I7PEOIVUoZrFr1aQ4u04CCatN14NKuMmFpVOyk1LJ40c6AQS2Bj2QwikhgUzAMpzWUdql8SwNDEqcmIrlL421tLC0pmjHT1reAGPJAkdBfJTl1tkHU2zRmPDQiUXTrCnc9nFgcjprlPtPG97BQ=="
    ];
  };
  users = {
    elliott = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6ZP8YiM5PTp6ZrgVVdJq8UVifTK8IvEiKN5i1vTnMX"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1+DUQegdnmPTIPRG5ohsC5JrMpUqRf3iHh8xaZG5QvrTIZkSq1H6bUK3A7y7WH6z7SrF8Jp4ccQnGm3B3/xQrfZo5Lhiv25pp04TYtDI1MLcN6PaRVJOPMwqWE0M8jdDXyAatgurwi7uNx0JjElPxyRD3bFC6CLmrt5RLqFqHV3/0eYVro3N68+FvywBjn2f50wCMwyLNjmlD3xY2h2z4Tz4/L4r8DgGgTUMSVIODNuBt3y1eSghmxYdLf4Ms9/e+HLLrqfozSH7n5dYK+BVYjAE/b1OakwhgLorr6kyKb4fVLOZXw0Exa0RQED3USXraWY1/jn4EhrkcWQBCQCzSzgOmuO6qW8obJPEtYpH8p5zNnCLymLrxrqPBgTnSannPNTy/uxlHu4BqpdRTM5SoiRdlezKUhGkokV9acotO5kqFd1mVYjYhhdBnuEJfq2vnRoOrF5WqnQWBMwwQldbEdNggVFPExQLccMKpLv/hO/qe9J3jgB1CYYZJQuujZHQ5On/XynexmhWI3u27aXHcF2aA2XdNbCDeG/2WmTm2IXDHBFUbz1rjBxpFK8Ts0olt7scjKf5RFZwPjfdY3CcPVt8/keRXqGvM9zsNs0cfPPHCmYVwl+S0RQYhWSSDZxeK7GG5xDvcmfdTi9pT0Y/yL/UvYB4bA54kdzdfpzYfRQ=="
    ];
  };

  all = builtins.concatLists ((builtins.attrValues hosts) ++ (builtins.attrValues users));
  broad = hosts.broad ++ users.elliott;
  lima = hosts.lima ++ users.elliott;
  runner = hosts.runner ++ users.elliott;
in
{

  /* --------------------------------- GitHub --------------------------------- */

  "modules/nixos/nix/github-pat.age".publicKeys = all;

  "systems/x86_64-linux/runner/github-runners/dotfiles.age".publicKeys = runner;
  "systems/x86_64-linux/runner/github-runners/key.age".publicKeys = runner;

  /* -------------------------------- TailScale ------------------------------- */

  "modules/nixos/networking/access/tailscale.age".publicKeys = all;

  /* --------------------------------- Docker --------------------------------- */

  "modules/nixos/virtualisation/docker/username.age".publicKeys = all;
  "modules/nixos/virtualisation/docker/password.age".publicKeys = all;

  /* ----------------------------------- SSH ---------------------------------- */

  "homes/x86_64-linux/elliott@lima/config/ssh/beannet/key.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/ssh/beannet/legacy.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/ssh/remarkable/key.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/ssh/sites/github.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/ssh/sites/python-anywhere.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/ssh/uos/key.age".publicKeys = lima;

  /* --------------------------------- rClone --------------------------------- */

  "homes/x86_64-linux/elliott@lima/config/rclone/DotFiles/url.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/rclone/DotFiles/id.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/rclone/DotFiles/key.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/rclone/DropBox/token.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/rclone/Google/token.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/rclone/OneDrive/id.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/rclone/OneDrive/token.age".publicKeys = lima;

  "homes/x86_64-linux/elliott@lima/config/rclone/Work/id.age".publicKeys = lima;
  "homes/x86_64-linux/elliott@lima/config/rclone/Work/token.age".publicKeys = lima;

  /* ----------------------------------- UoS ---------------------------------- */

  "modules/nixos/uos/networking/env.age".publicKeys = all;

  /* -------------------------------- Home Lab -------------------------------- */

  "systems/x86_64-linux/broad/services/secret.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/password.age".publicKeys = broad;

  "systems/x86_64-linux/broad/services/core/backup/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/secret.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/token.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/cloudflare-url.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/cloudflare-id.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/cloudflare-key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/backup/auth.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/ddns/cloudflare.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/proxy/cloudflare.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/core/vpn/key.age".publicKeys = broad;

  "systems/x86_64-linux/broad/services/games/romm/igdb-id.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/games/romm/igdb.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/games/romm/steamgriddb.age".publicKeys = broad;

  "systems/x86_64-linux/broad/services/media/jellyfin/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/jellyseerr/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/prowlarr/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/prowlarr/indexers/nzbgeek.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/radarr/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/sabnzbd/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/sabnzbd/nzb.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/sonarr/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/media/tubearchivist/key.age".publicKeys = broad;

  "systems/x86_64-linux/broad/services/monitor/portainer/key.age".publicKeys = broad;
  "systems/x86_64-linux/broad/services/monitor/speedtest-tracker/key.age".publicKeys = broad;

}
