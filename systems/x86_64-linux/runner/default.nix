{ ...
}:

{
  imports = [
    ./services
  ];

  # environment.persistence."/persistent" = {
  #   hideMounts = true;
  #   directories = [
  #     "/var/lib/nixos"
  #     "/var/lib/tailscale"
  #   ];
  #   files = [
  #     "/etc/ssh/ssh_host_ed25519_key"
  #     "/etc/ssh/ssh_host_ed25519_key.pub"
  #     "/etc/ssh/ssh_host_rsa_key"
  #     "/etc/ssh/ssh_host_rsa_key.pub"
  #   ];
  #   users.root = {
  #     home = "/root";
  #     files = [
  #       ".ssh/id_ed25519"
  #       ".ssh/id_ed25519.pub"
  #       ".ssh/id_rsa"
  #       ".ssh/id_rsa.pub"
  #     ];
  #   };
  # };

}
