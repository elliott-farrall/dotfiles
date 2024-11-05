{ pkgs
, ...
}:

let
  package = pkgs.writeShellScriptBin "container" /*sh*/''
    #!/bin/sh

    BACKEND=podman

    case "$1" in
      ls)
        systemctl list-units podman-*
        exit 0
        ;;
      start)
        if [ -n "$2" ]; then
          systemctl start $BACKEND-$2.service
          exit 0
        else
          systemctl start $BACKEND-compose-$(hostname)-root.target
          exit 0
        fi
        ;;
      stop)
        if [ -n "$2" ]; then
          systemctl stop $BACKEND-$2.service
          exit 0
        else
          systemctl stop $BACKEND-compose-$(hostname)-root.target
          exit 0
        fi
        ;;
      restart)
        if [ -n "$2" ]; then
          systemctl restart $BACKEND-$2.service
          exit 0
        else
          systemctl restart $BACKEND-compose-$(hostname)-root.target
          exit 0
        fi
        ;;
      logs)
        if [ -n "$2" ]; then
          journalctl -xeu $BACKEND-$2.service
        else
          journalctl -xeu $BACKEND-compose-$(hostname)-root.target
          exit 0
        fi
        ;;
      *)
        echo "Usage: $0 {ls|start|stop|restart|logs} ..."
        exit 1
        ;;
    esac
  '';
in
{
  environment.systemPackages = [
    package
  ];
}
