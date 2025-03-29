let
  hosts = {
    broad = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmVhqowDJawyr/RWEbc3HEQuiPDYsBFUniOd24Le4CB"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXtthyTu9Tj18yAXVjiIW3T91DmyXYF089f4iC2h4S8MBGolIGutTLiG+HfYmovyd5Hw8ZuE9xnYn0nyoQfqPWYDnjHE1FtX04owN2N1EgHE92SpfLzP+YTD2Rarf1Ct2NQ+XiLuHtpKDdN+/NQ1oJ4A9vW0n82R5G78QGIs0MPL2aE2YiOJo7K8re19swSniAzAyaACgC5M31lLdvKgxKH2qTzXV30fWzE95WKdjkT56yxPHf0oPPZqcfJlnxCYouz4p4LKOqAZ0IIu6h1CHoAArM3PED+wF5c5KG7KHuBTdRb3vO8mdKObLPGCdiOUhRrFdSnB3Wpu18YhyPBJGHt2eqnUeAp9YD+mT+cc1K0qChZZlh3audT7/3YgAfZaD+QGA3hdV6qWWevSRjSqUi4ZsolxJligvrVLmZeeo9x+QglROKvEadNg+sME/Qz0e0yRD0EKoewMRFGj/nZQPI0/3pxGIwSWrr4PvRrWTp/tgu4TTNUEaDCKQVW1pdpZI4q7a9WT7DEFjJ4ZnMyx3gFKKCEySfQA4KQ4CgM/OiqlVGMEAmMDzdPo/J3Pa43Q1eIO53GN7XyJta3RSwPo1MWRLBNw/UwB/UQXL1tyXGgGMDpNgvttcbOpBcqVvzMY4XejPofohvjOB0gslwLBeUE6dOn+YxHreURyoXiJMZcw=="
    ];
    lima = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJCAOPR5Bi2UtRkI1OR4qYJg1nu7yXvAWZ9a9BaBsKBa"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgg8i5/pe2Idssxymdfzzh5pH5xj1SXTW3hLw0240Oy63JIj9PoPOBr63M50Sa5QYQusF0mTeOLTeQuKwLOF4/PBNDEGZAq2TpX8sDFXh9VxTUJm3knnGDEKPReuXev+LUk9l+1K9HQQ8P8tMu9Qkj/QruXT8OUnLq94cCQdZ3vZ9ddJdcpyMokP+Z98HSp/d+2wWC8WhKvNA5URhTT9xfEsxstyaE1MGzJ/EyDiPpdSTVMt27rH+13BiDVknqGSekOCk52PrqS15dCv0NE9D17mWjjV4/D9iReWG/bdk6UmpNBgjIpxpTsnER70LydscKMisIPgV5ip+20QKgjvin1qdRMdkItyYXn+bomiZzauyubkWVoJlGFsocQIXsBX6YyyFeR/J1hWPZDBcxN5KAwlAWGJUJTD8HpyQhfdn56q9oRRfjYF2nQCEXd5NHr/6OgnZBLm02eC+XNxGewieqhxLoP25pUrJopAnifXlgBRn8cXV1A9iTB/AQcdIqEOT4Cefhf7+j+ixTkH/sMYDEnx3h8oti+ui4zQo/KvtIJsWWZ1jQ6kp5upIUO2Rz1rRnY/Pyhk3FphFbNzUn6Zu8r/rwbopIxcjjjGVjsX0QxhlE0z4BbUPvyGzOpn3gPObFnA4H8ghG2r73yTq8t2FIQlNK+cLufZGZ8AyTDcQ1DQ=="
    ];
    # runner = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxusHQ2pl0rolgCbmRglvbaB2k1nNtSRI0eclZEkW82"
    #   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCPlIADzKCiltZc1cpgHM0WVqMJlaQnLdLqK5takGEuG0mILcEqywJFl18e1MA5GZfvK7nSQI/0zK/TzO8V4uW7/WW6JLbB15mbS77sjGrChnk10ZeJrTKA0FY8OQYGaaADorYpvDT92+gAnL/Rgi6AWWNO7uGLZ6bBJERwkvtqYOoAn7RtIj1xRaitUuVkT9pP2DIqhy1oVs7KqzNy3Oj72XW0LMjqUU2AMo3172L4/hmekNelTpEfZOXi9Kz1C/MmYO4zy9PIxhYhVSI/ofoD+nJ6LkPIgvY7olnqLalWFfNPQjn70hjEYxo/+6c7HUCWs4rjVdljqDExIRkgXmQ6n0EwPUq/MOxf+L9SVj28ahnK3EKfDULiSQ4kE762WcUVZNCZmlGvV5iixdwhXOq8hQD1hSLThnJrQWdlB7LsK+TjLgJvEqheLeD0wo8vb99F9FhPAiDY3xOR3kdVK9FKqEnDsedxDBWm1SzC4HFmucqPIMEziRzH+SvSMbZ3/NiBgwl2CUV8R/YnEq5f6GXXhd7cQM7CfZTfg+n9HmAx5NooYZWd+8Al9W5JsX17SBuNCLuty2P4JQHyZ2+3fA/X2TTMEDkBftkqqCUkLDa68u2PuKJMu9aCC4eetogyDhR5lY9iJwRuOrywDz/bv/WN1Kk1FxeY5BgcuF/SjrzPrw=="
    # ];
    runner = [
      "age1mvvydcq686dprhhwrmr48kd7k60g4tjpw9yk9ndt8emjr3k4jfdsq2ttl6"
    ];
  };
  users = {
    elliott = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmUNOJdQxJX+v6+fTY7mQzUFjeRajUYPtjtVNilY/jN"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCejwvxNLgqkvej5gm5ybwj/cBkqZTfvhYLEoOLepQGb2lhnILL7A1gA0q2XkVYA2tvttm+QsTMxCkRFQ3yXVfko7+obGqNJJ95hGeqxwZw6+DHFhdx3mk4lxGfm+siqwm0LhyugH6USIzkKST3/QjgmK2ZsyQtrvdDYoPwl/JOBdEtaL1lCc2PoqBbIOR2a0kK1xbiLRVc3rkcKoF1suZIwRvh7XyxzQxoVv5S5pwMbm0ePFgIQtEsAF80MvRrKs0agMWTwhzdWHo4iWLHyVCjMi4tHQyJZ0OnFuuhys5IA2cySkkSQur8QdLPKPt4MrESwlaNOVh2D54VbgKefuJow0NByI5Ua95Jr4v+HqHYZQAxTcBCvnhEy4PHEcwTR0w7mRcDbP+Y09m/C786zW+FdIRrRHGmjz+jhfcFC3Zk1ehIauJrPxRKFM0gyfdqcRUfEVBBfWkbfdBVK9FjFBmAzXk6Ci6K85FlZqRWFWbT3uZGp95dnh5bqx+FwAPVvaBpwUpsccoHP0vMmL9pWZXtUizZH9CLow0+sdgLgtQtdeQr8XuPXzNrI8gkMetQtzN8u0clWFU571ipArPuQ5W0F3gCSYczEx0XZ38kEHUo4QFwUJkGtse4H3cklUyYtkQcsRDs4Qt/EgmqKiDv5ceHBcZCKcSvTJKJDi/PbzeFhQ=="
    ];
    root = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUjxl1444qMm7/Xp2MTZIoU31m1j/UsThn5a3ql1lD2"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCN/Yz6cpeYKkinW0eVRZxMKwYWkgtGGCM5XTg3MonpTwnsFWloib90GdYnidFfRtRo14tLc166FJ657oPeomgmnpkTWqd0kCuezL4775gpse/1o8AVwgEAYMMACnYqmo+hFls5Y7ZiZ+GYO34W2UUjrZFu9V/OuFOooydcSSNFmobakhxdCyJhurJ5x77xhnBqo3+tgvsHJjv5l4m2SLB5ea5ds/luGequJaXbVn9p5rjMsej0dPF7a46u6RkyQD98442gKzCSGOW0fW/mKaNPtsks57BuPiVeJT2lMHqMRxpYIxx4SeG48jTfdZICkXk9el0V9DLciYS+2vG+kSaAUX8FdbRIblxLJYuWBWL6joFF+sKqJJS/2y9JdJ3qYWOxOjFpqTaZvHzKo9t6XQhB4PD1N7EbvEwq6+XtVde2RB3TOAUAhkiBlbw/svql6U//IVDq6mgwIAhfIRbi9X2BMfiPhOrhsz9TPa047EjoSJHjb9Kr1ItEkcVRwfe8AeSTDb0fs5leMP/aFrKS1D1hqaocABkq4+TuqwtwSpkRzt5v21cZ4gaAG61Qq3Jhe8QETZjGPrGdq1R8AZxo9lT4Rx9OQyixj6tYJ6HfFlgKLq8Z4xfWmmEgn251ySOORGBiNSYBpF2ne/rwzdtZnxAZd/cwI1LtuNw1vb1JC0Gilw=="
    ];
  };

  all = builtins.concatLists ((builtins.attrValues hosts) ++ (builtins.attrValues users));
  broad = hosts.broad ++ users.elliott;
  lima = hosts.lima ++ users.elliott;
  runner = hosts.runner ++ users.elliott;
in
{

  /* --------------------------------- Docker --------------------------------- */

  "modules/nixos/virtualisation/docker/username.age".publicKeys = all;
  "modules/nixos/virtualisation/docker/password.age".publicKeys = all;

  /* --------------------------------- GitHub --------------------------------- */

  "modules/home/git/sign.age".publicKeys = all;
  "modules/home/git/github/auth.age".publicKeys = all;
  "modules/home/git/azure/auth.age".publicKeys = all;
  

  "modules/nixos/nix/settings/pat.age".publicKeys = all;

  "systems/x86_64-linux/runner/services/github-runners/repos/dotfiles.age".publicKeys = runner;
  "systems/x86_64-linux/runner/services/renovate/token.age".publicKeys = runner;

  /* -------------------------------- Home Lab -------------------------------- */

  "modules/home/networking/ssh/beannet/root.age".publicKeys = all;
  "modules/home/networking/ssh/beannet/elliott.age".publicKeys = all;

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

  /* ----------------------------- PythonAnywhere ----------------------------- */

  "modules/home/networking/ssh/python-anywhere/key.age".publicKeys = all;

  /* --------------------------------- rClone --------------------------------- */

  "modules/home/rclone/DotFiles/url.age".publicKeys = lima;
  "modules/home/rclone/DotFiles/id.age".publicKeys = lima;
  "modules/home/rclone/DotFiles/key.age".publicKeys = lima;

  "modules/home/rclone/DropBox/token.age".publicKeys = lima;

  "modules/home/rclone/Google/token.age".publicKeys = lima;

  "modules/home/rclone/OneDrive/id.age".publicKeys = lima;
  "modules/home/rclone/OneDrive/token.age".publicKeys = lima;

  "modules/home/rclone/Work/id.age".publicKeys = lima;
  "modules/home/rclone/Work/token.age".publicKeys = lima;

  /* -------------------------------- TailScale ------------------------------- */

  "modules/nixos/networking/tailscale/auth.age".publicKeys = all;

  /* ----------------------------------- UoS ---------------------------------- */

  "modules/nixos/profiles/uos/networking/env.age".publicKeys = all;

  "modules/home/profiles/uos/ssh/key.age".publicKeys = all;

}
