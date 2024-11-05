{ pkgs
, ...
}:

let
  package = pkgs.writeShellScriptBin "volume" /*sh*/''
    #!/bin/sh

    BACKEND=podman

    BACKUP_CONTAINER=backup

    case "$1" in
      ls)
        docker volume ls
        exit 0
        ;;
      prune)
        docker volume prune
        exit 0
        ;;
      rm)
        if [ -n "$2" ]; then
          docker volume rm $2
          exit 0
        else
          echo "Usage: $0 rm <volume_name>"
          exit 1
        fi
        ;;
      backup)
        docker exec $BACKUP_CONTAINER backup
        exit 0
        ;;
      restore)
        if [ -n "$2" ] && [ -n "$3" ]; then
          # Get container names using the volume
          containers=$(docker ps -a --filter volume=$2 --format "{{.Names}}")

          # Stop the containers
          for container in $containers; do
            systemctl stop $BACKEND-$container.service
          done

          # Recreate the volume
          docker volume rm $2 > /dev/null
          docker run --rm -it -v $2:/backup/$2 -v $(dirname $3):/archive:ro alpine tar -xzf /archive/$(basename $3) > /dev/null

          # Start the containers
          for container in $containers; do
            systemctl start $BACKEND-$container.service
          done

          exit 0
        else
          echo "Usage: $0 restore <volue_name> <archive>"
          exit 1
        fi
        ;;
      *)
        echo "Usage: $0 {ls|prune|rm|backup|restore} ..."
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
