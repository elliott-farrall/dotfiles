let
  nixpkgs = import <nixpkgs> { };
  inherit (nixpkgs) lib;

  ageFiles = lib.fileset.toList (
    lib.fileset.fileFilter (file: file.hasExt "age") ./.
  );

  hosts = {
    broad = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmVhqowDJawyr/RWEbc3HEQuiPDYsBFUniOd24Le4CB"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXtthyTu9Tj18yAXVjiIW3T91DmyXYF089f4iC2h4S8MBGolIGutTLiG+HfYmovyd5Hw8ZuE9xnYn0nyoQfqPWYDnjHE1FtX04owN2N1EgHE92SpfLzP+YTD2Rarf1Ct2NQ+XiLuHtpKDdN+/NQ1oJ4A9vW0n82R5G78QGIs0MPL2aE2YiOJo7K8re19swSniAzAyaACgC5M31lLdvKgxKH2qTzXV30fWzE95WKdjkT56yxPHf0oPPZqcfJlnxCYouz4p4LKOqAZ0IIu6h1CHoAArM3PED+wF5c5KG7KHuBTdRb3vO8mdKObLPGCdiOUhRrFdSnB3Wpu18YhyPBJGHt2eqnUeAp9YD+mT+cc1K0qChZZlh3audT7/3YgAfZaD+QGA3hdV6qWWevSRjSqUi4ZsolxJligvrVLmZeeo9x+QglROKvEadNg+sME/Qz0e0yRD0EKoewMRFGj/nZQPI0/3pxGIwSWrr4PvRrWTp/tgu4TTNUEaDCKQVW1pdpZI4q7a9WT7DEFjJ4ZnMyx3gFKKCEySfQA4KQ4CgM/OiqlVGMEAmMDzdPo/J3Pa43Q1eIO53GN7XyJta3RSwPo1MWRLBNw/UwB/UQXL1tyXGgGMDpNgvttcbOpBcqVvzMY4XejPofohvjOB0gslwLBeUE6dOn+YxHreURyoXiJMZcw=="
    ];
    lima = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJCAOPR5Bi2UtRkI1OR4qYJg1nu7yXvAWZ9a9BaBsKBa"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgg8i5/pe2Idssxymdfzzh5pH5xj1SXTW3hLw0240Oy63JIj9PoPOBr63M50Sa5QYQusF0mTeOLTeQuKwLOF4/PBNDEGZAq2TpX8sDFXh9VxTUJm3knnGDEKPReuXev+LUk9l+1K9HQQ8P8tMu9Qkj/QruXT8OUnLq94cCQdZ3vZ9ddJdcpyMokP+Z98HSp/d+2wWC8WhKvNA5URhTT9xfEsxstyaE1MGzJ/EyDiPpdSTVMt27rH+13BiDVknqGSekOCk52PrqS15dCv0NE9D17mWjjV4/D9iReWG/bdk6UmpNBgjIpxpTsnER70LydscKMisIPgV5ip+20QKgjvin1qdRMdkItyYXn+bomiZzauyubkWVoJlGFsocQIXsBX6YyyFeR/J1hWPZDBcxN5KAwlAWGJUJTD8HpyQhfdn56q9oRRfjYF2nQCEXd5NHr/6OgnZBLm02eC+XNxGewieqhxLoP25pUrJopAnifXlgBRn8cXV1A9iTB/AQcdIqEOT4Cefhf7+j+ixTkH/sMYDEnx3h8oti+ui4zQo/KvtIJsWWZ1jQ6kp5upIUO2Rz1rRnY/Pyhk3FphFbNzUn6Zu8r/rwbopIxcjjjGVjsX0QxhlE0z4BbUPvyGzOpn3gPObFnA4H8ghG2r73yTq8t2FIQlNK+cLufZGZ8AyTDcQ1DQ=="
    ];
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

  keys = {
    all = builtins.concatLists ((builtins.attrValues hosts) ++ (builtins.attrValues users));
    broad = hosts.broad ++ users.elliott;
    lima = hosts.lima ++ users.elliott;
    runner = hosts.runner ++ users.elliott;
  };

  getKeyName = path:
    if builtins.match "templates/.*" path != null then "all"
    else if builtins.match "modules/.*" path != null then "all"
    else if builtins.match "systems/x86_64-linux/broad/.*" path != null then "broad"
    else if builtins.match "systems/x86_64-linux/lima/.*" path != null then "lima"
    else if builtins.match "systems/x86_64-linux/runner/.*" path != null then "runner"
    else if builtins.match "homes/x86_64-linux/elliott@lima/.*" path != null then "lima"
    else "all";

in
builtins.listToAttrs (map
  (file: {
    name = lib.removePrefix "./" (lib.path.removePrefix ./. file);
    value.publicKeys = keys.${getKeyName (toString file)};
  })
  ageFiles)
