{ pkgs
, ...
}:

{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    kubectl
    minikube
    kubernetes-helm
  ];
}
