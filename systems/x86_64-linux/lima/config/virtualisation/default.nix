{ pkgs
, ...
}:

{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    kubectl
    minikube
    kubernetes-helm
  ];
}
