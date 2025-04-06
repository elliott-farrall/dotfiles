# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."auth" = {
    image = "docker.io/authelia/authelia:4.39.1";
    volumes = [
      "/etc/broad/auth/config.yaml:/config/configuration.yml:ro"
      "/etc/localtime:/etc/localtime:ro"
      "data-auth:/data:rw"
      "temp-auth:/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "kuma.auth-external.port.hostname" = "auth.beannet.app";
      "kuma.auth-external.port.name" = "External";
      "kuma.auth-external.port.parent_name" = "auth";
      "kuma.auth-external.port.port" = "8443";
      "traefik.enable" = "true";
      "traefik.http.routers.auth.entrypoints" = "auth";
      "traefik.http.services.auth.loadbalancer.server.port" = "9091";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "ldap"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:9091 || exit 1"
      "--network-alias=auth"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-auth" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-auth.service"
      "podman-volume-temp-auth.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-auth.service"
      "podman-volume-temp-auth.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."autoheal" = {
    image = "docker.io/willfarrell/autoheal:1.2.0";
    environment = {
      "AUTOHEAL_START_PERIOD" = "300";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=autoheal"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-autoheal" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."autokuma" = {
    image = "ghcr.io/bigboot/autokuma:sha-1bd6e85";
    environment = {
      "AUTOKUMA__KUMA__URL" = "http://uptime-kuma:3001";
      "AUTOKUMA__SNIPPETS__EXTERNAL" = "{{ container_name }}-external.http.name: external
  {{ container_name }}-external.http.parent_name: {{ container_name }}
  {{ container_name }}-external.http.url: https://{{ container_name }}.beannet.app";
      "AUTOKUMA__SNIPPETS__INTERNAL" = "{{ container_name }}-internal.docker.name: internal
  {{ container_name }}-internal.docker.parent_name: {{ container_name}}
  {{ container_name }}-internal.docker.docker_host_name: broad
  {{ container_name }}-internal.docker.docker_container: {{ container_name }}";
      "AUTOKUMA__SNIPPETS__SERVICE" = "{{ container_name }}.group.name: {{ container_name }}
  {{ container_name }}.group.parent_name: services";
      "AUTOKUMA__STATIC_MONITORS" = "/static";
    };
    volumes = [
      "/etc/broad/uptime-kuma/monitors:/static:ro"
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "kuma.broad.docker_host.connection_type" = "socket";
      "kuma.broad.docker_host.docker_daemon" = "/var/run/docker.sock";
      "kuma.services.group.name" = "services";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "uptime-kuma"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=autokuma"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-autokuma" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."backup" = {
    image = "ghcr.io/offen/docker-volume-backup:v2.43.3";
    environment = {
      "AWS_S3_BUCKET_NAME" = "broad";
      "BACKUP_LATEST_SYMLINK" = "backup.latest.tar.gz";
      "DROPBOX_REMOTE_PATH" = "/Apps/beannet";
    };
    environmentFiles = [
      "/etc/broad/backup/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "backup-volume:/archive:rw"
      "data-auth:/backup/data-auth:ro"
      "data-jellyfin:/backup/data-jellyfin:ro"
      "data-jellyseerr:/backup/data-jellyseerr:ro"
      "data-ldap:/backup/data-ldap:ro"
      "data-myspeed:/backup/data-myspeed:ro"
      "data-netalertx:/backup/data-netalertx:ro"
      "data-portainer:/backup/data-portainer:ro"
      "data-prowlarr:/backup/data-prowlarr:ro"
      "data-proxy:/backup/data-proxy:ro"
      "data-qbittorrent:/backup/data-qbittorrent:ro"
      "data-radarr:/backup/data-radarr:ro"
      "data-romm:/backup/data-romm:ro"
      "data-romm-db:/backup/data-romm-db:ro"
      "data-sabnzbd:/backup/data-sabnzbd:ro"
      "data-sonarr:/backup/data-sonarr:ro"
      "data-speedtest-tracker:/backup/data-speedtest-tracker:ro"
      "data-tubearchivist:/backup/data-tubearchivist:ro"
      "data-tubearchivist-es:/backup/data-tubearchivist-es:ro"
      "data-tubearchivist-redis:/backup/data-tubearchivist-redis:ro"
      "data-uptime-kuma:/backup/data-uptime-kuma:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=backup"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-backup" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-backup-volume.service"
      "podman-volume-data-auth.service"
      "podman-volume-data-jellyfin.service"
      "podman-volume-data-jellyseerr.service"
      "podman-volume-data-ldap.service"
      "podman-volume-data-myspeed.service"
      "podman-volume-data-netalertx.service"
      "podman-volume-data-portainer.service"
      "podman-volume-data-prowlarr.service"
      "podman-volume-data-proxy.service"
      "podman-volume-data-qbittorrent.service"
      "podman-volume-data-radarr.service"
      "podman-volume-data-romm-db.service"
      "podman-volume-data-romm.service"
      "podman-volume-data-sabnzbd.service"
      "podman-volume-data-sonarr.service"
      "podman-volume-data-speedtest-tracker.service"
      "podman-volume-data-tubearchivist-es.service"
      "podman-volume-data-tubearchivist-redis.service"
      "podman-volume-data-tubearchivist.service"
      "podman-volume-data-uptime-kuma.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-backup-volume.service"
      "podman-volume-data-auth.service"
      "podman-volume-data-jellyfin.service"
      "podman-volume-data-jellyseerr.service"
      "podman-volume-data-ldap.service"
      "podman-volume-data-myspeed.service"
      "podman-volume-data-netalertx.service"
      "podman-volume-data-portainer.service"
      "podman-volume-data-prowlarr.service"
      "podman-volume-data-proxy.service"
      "podman-volume-data-qbittorrent.service"
      "podman-volume-data-radarr.service"
      "podman-volume-data-romm-db.service"
      "podman-volume-data-romm.service"
      "podman-volume-data-sabnzbd.service"
      "podman-volume-data-sonarr.service"
      "podman-volume-data-speedtest-tracker.service"
      "podman-volume-data-tubearchivist-es.service"
      "podman-volume-data-tubearchivist-redis.service"
      "podman-volume-data-tubearchivist.service"
      "podman-volume-data-uptime-kuma.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."buildarr" = {
    image = "docker.io/callum027/buildarr:0.7.8";
    volumes = [
      "/etc/broad/buildarr/config.yaml:/config/buildarr.yml:ro"
      "/etc/localtime:/etc/localtime:ro"
      "temp-buildarr:/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "jellyseerr"
      "jellyseerr-check"
      "prowlarr"
      "radarr"
      "sonarr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=buildarr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-buildarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-temp-buildarr.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-temp-buildarr.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."ddns" = {
    image = "docker.io/favonia/cloudflare-ddns:1.15.1";
    environment = {
      "CF_API_TOKEN_FILE" = "/token";
      "DOMAINS" = "beannet.app, *.beannet.app";
      "IP6_PROVIDER" = "none";
      "PROXIED" = "true";
    };
    volumes = [
      "/etc/broad/ddns/cloudflare:/token:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    user = "0:0";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=ddns"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-ddns" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dns" = {
    image = "docker.io/spx01/blocky:v0.25";
    volumes = [
      "/etc/broad/dns/config.yaml:/app/config.yml:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dns"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-dns" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."fileflows" = {
    image = "docker.io/revenz/fileflows:25.04";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.description" = "FileFlows is a file processing application that can execute actions against a file in a tree flow structure.";
      "homepage.group" = "Media";
      "homepage.href" = "https://fileflows.beannet.app";
      "homepage.icon" = "fileflows";
      "homepage.name" = "Fileflows";
      "homepage.siteMonitor" = "https://fileflows.beannet.app";
      "homepage.widget.type" = "fileflows";
      "homepage.widget.url" = "http://fileflows:5000";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.fileflows.loadbalancer.server.port" = "5000";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "false";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:5000 || exit 1"
      "--network-alias=fileflows"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-fileflows" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."flaresolverr" = {
    image = "ghcr.io/flaresolverr/flaresolverr:v3.3.21";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=flaresolverr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-flaresolverr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."glances" = {
    image = "docker.io/nicolargo/glances:4.3.0.8";
    environment = {
      "GLANCES_OPT" = "-w";
    };
    volumes = [
      "/etc/broad/glances/config.conf:/glances/conf/glances.conf:ro"
      "/etc/localtime:/etc/localtime:ro"
      "/etc/os-release:/etc/os-release:ro"
      "/mnt/storage:/mnt/broad/storage:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://glances.beannet.app";
      "homepage.icon" = "glances";
      "homepage.name" = "Glances";
      "homepage.siteMonitor" = "https://glances.beannet.app";
      "homepage.widget.metric" = "info";
      "homepage.widget.type" = "glances";
      "homepage.widget.url" = "http://glances:61208";
      "homepage.widget.version" = "4";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.glances.loadbalancer.server.port" = "61208";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:61208 || exit 1"
      "--network-alias=glances"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-glances" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."homepage" = {
    image = "ghcr.io/gethomepage/homepage:v1.1.1";
    environment = {
      "HOMEPAGE_FILE_JELLYFIN_KEY" = "/keys/jellyfin";
      "HOMEPAGE_FILE_JELLYSEERR_KEY" = "/keys/jellyseerr";
      "HOMEPAGE_FILE_PORTAINER_KEY" = "/keys/portainer";
      "HOMEPAGE_FILE_PROWLARR_KEY" = "/keys/prowlarr";
      "HOMEPAGE_FILE_QBITTORRENT_PASSWORD" = "/keys/password";
      "HOMEPAGE_FILE_RADARR_KEY" = "/keys/radarr";
      "HOMEPAGE_FILE_ROMM_PASSWORD" = "/keys/password";
      "HOMEPAGE_FILE_SABNZBD_KEY" = "/keys/sabnzbd";
      "HOMEPAGE_FILE_SONARR_KEY" = "/keys/sonarr";
      "HOMEPAGE_FILE_TUBEARCHIVIST_KEY" = "/keys/tubearchivist";
    };
    volumes = [
      "/etc/broad/homepage/_blank.yaml:/app/config/services.yaml:ro"
      "/etc/broad/homepage/bookmarks.yaml:/app/config/bookmarks.yaml:ro"
      "/etc/broad/homepage/docker.yaml:/app/config/docker.yaml:ro"
      "/etc/broad/homepage/settings.yaml:/app/config/settings.yaml:ro"
      "/etc/broad/homepage/widgets.yaml:/app/config/widgets.yaml:ro"
      "/etc/broad/jellyfin/key:/keys/jellyfin:ro"
      "/etc/broad/jellyseerr/key:/keys/jellyseerr:ro"
      "/etc/broad/password:/keys/password:ro"
      "/etc/broad/portainer/key:/keys/portainer:ro"
      "/etc/broad/prowlarr/key:/keys/prowlarr:ro"
      "/etc/broad/radarr/key:/keys/radarr:ro"
      "/etc/broad/sabnzbd/key:/keys/sabnzbd:ro"
      "/etc/broad/sonarr/key:/keys/sonarr:ro"
      "/etc/broad/tubearchivist/key:/keys/tubearchivist:ro"
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.homepage.loadbalancer.server.port" = "3000";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1"
      "--network-alias=homepage"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-homepage" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "docker.io/linuxserver/jellyfin:2021.12.16";
    environment = {
      "JELLYFIN_PublishedServerUrl" = "jellyfin.beannet.app";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-jellyfin:/config:rw"
      "media-anime:/data/anime:rw"
      "media-movies:/data/movies:rw"
      "media-shows:/data/shows:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Main";
      "homepage.href" = "https://jellyfin.beannet.app";
      "homepage.icon" = "jellyfin";
      "homepage.name" = "Jellyfin";
      "homepage.siteMonitor" = "https://jellyfin.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_JELLYFIN_KEY}}";
      "homepage.widget.type" = "jellyfin";
      "homepage.widget.url" = "http://jellyfin:8096";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-jellyfin.plugin.themepark.app" = "jellyfin";
      "traefik.http.middlewares.theme-jellyfin.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.jellyfin.middlewares" = "theme-jellyfin";
      "traefik.http.services.jellyfin.loadbalancer.server.port" = "8096";
      "wud.tag.exclude" = "^\\\\d\\\\d\\\\d\\\\d\\\\.\\\\d\\\\d\\\\.\\\\d\\\\d$$";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:8096 || exit 1"
      "--network-alias=jellyfin"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-jellyfin" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-jellyfin.service"
      "podman-volume-media-anime.service"
      "podman-volume-media-movies.service"
      "podman-volume-media-shows.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-jellyfin.service"
      "podman-volume-media-anime.service"
      "podman-volume-media-movies.service"
      "podman-volume-media-shows.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."jellyseerr" = {
    image = "docker.io/fallenbagel/jellyseerr:2.5.2";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-jellyseerr:/app/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Main";
      "homepage.href" = "https://jellyseerr.beannet.app";
      "homepage.icon" = "jellyseerr";
      "homepage.name" = "Jellyseerr";
      "homepage.siteMonitor" = "https://jellyseerr.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_JELLYSEERR_KEY}}";
      "homepage.widget.type" = "jellyseerr";
      "homepage.widget.url" = "http://jellyseerr:5055";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.jellyseerr.loadbalancer.server.port" = "5055";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:5055 || exit 1"
      "--network-alias=jellyseerr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-jellyseerr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-jellyseerr.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-jellyseerr.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."jellyseerr-check" = {
    image = "docker.io/jwilder/dockerize:v0.9.3";
    cmd = [ "dockerize" "-wait=http://jellyseerr:5055" "-timeout" "180s" ];
    labels = {
      "compose2nix.systemd.service.Type" = "oneshot";
    };
    dependsOn = [
      "jellyseerr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=jellyseerr-check"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-jellyseerr-check" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
      Type = lib.mkOverride 90 "oneshot";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."ldap" = {
    image = "docker.io/nitnelave/lldap:2024-09-02-alpine-rootless";
    volumes = [
      "/etc/broad/ldap/config.toml:/data/lldap_config.toml:ro"
      "/etc/localtime:/etc/localtime:ro"
      "data-ldap:/data:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Network";
      "homepage.href" = "https://ldap.beannet.app";
      "homepage.icon" = "https://i0.wp.com/ldap.com/wp-content/uploads/2018/04/ldapdotcom-transparent-background-without-text-768x768.png";
      "homepage.name" = "LDAP";
      "homepage.siteMonitor" = "https://ldap.beannet.app";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.ldap.loadbalancer.server.port" = "17170";
      "wud.tag.include" = "^\\\\d\\\\d\\\\d\\\\d-\\\\d\\\\d-\\\\d\\\\d-alpine-rootless$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=timeout 10s bash -c ':> /dev/tcp/localhost/17170' || exit 1"
      "--network-alias=ldap"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-ldap" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-ldap.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-ldap.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."myspeed" = {
    image = "docker.io/germannewsmaker/myspeed:1.0.9";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-myspeed:/myspeed/data:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://myspeed.beannet.app";
      "homepage.icon" = "https://camo.githubusercontent.com/4ccc83cf6b1f06e999c378bda264433ec83994031c156a5c88876b53eb57b201/68747470733a2f2f692e696d6775722e636f6d2f61436d413672482e706e67";
      "homepage.name" = "MySpeed";
      "homepage.siteMonitor" = "https://myspeed.beannet.app";
      "homepage.widget.type" = "myspeed";
      "homepage.widget.url" = "http://myspeed:5216";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.myspeed.loadbalancer.server.port" = "5216";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:5216 || exit 1"
      "--network-alias=myspeed"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-myspeed" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-myspeed.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-myspeed.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."netalertx" = {
    image = "docker.io/jokobsk/netalertx:25.4.1";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-netalertx:/app/db:rw"
      "temp-netalertx:/app/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://netalertx.beannet.app";
      "homepage.icon" = "netalertx";
      "homepage.name" = "NetAlertX";
      "homepage.siteMonitor" = "https://netalertx.beannet.app";
      "homepage.widget.type" = "netalertx";
      "homepage.widget.url" = "http://netalertx:20211";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.netalertx.loadbalancer.server.port" = "20211";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:20211 || exit 1"
      "--network-alias=netalertx"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-netalertx" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-netalertx.service"
      "podman-volume-temp-netalertx.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-netalertx.service"
      "podman-volume-temp-netalertx.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."portainer" = {
    image = "docker.io/portainer/portainer-ce:2.28.1-alpine";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "data-portainer:/data:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://portainer.beannet.app";
      "homepage.icon" = "portainer";
      "homepage.name" = "Portainer";
      "homepage.siteMonitor" = "https://portainer.beannet.app";
      "homepage.widget.env" = "2";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_PORTAINER_KEY}}";
      "homepage.widget.type" = "portainer";
      "homepage.widget.url" = "http://portainer:9000";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-portainer.plugin.themepark.app" = "portainer";
      "traefik.http.middlewares.theme-portainer.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.portainer.middlewares" = "theme-portainer";
      "traefik.http.services.portainer.loadbalancer.server.port" = "9000";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+-alpine$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:9000 || exit 1"
      "--network-alias=portainer"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-portainer" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-portainer.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-portainer.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."prowlarr" = {
    image = "docker.io/linuxserver/prowlarr:1.32.2";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-prowlarr:/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Media";
      "homepage.href" = "https://prowlarr.beannet.app";
      "homepage.icon" = "prowlarr";
      "homepage.name" = "Prowlarr";
      "homepage.siteMonitor" = "https://prowlarr.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_PROWLARR_KEY}}";
      "homepage.widget.type" = "prowlarr";
      "homepage.widget.url" = "http://prowlarr:9696";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-prowlarr.plugin.themepark.app" = "prowlarr";
      "traefik.http.middlewares.theme-prowlarr.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.prowlarr.middlewares" = "theme-prowlarr";
      "traefik.http.services.prowlarr.loadbalancer.server.port" = "9696";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:9696 || exit 1"
      "--network-alias=prowlarr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-prowlarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-prowlarr.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-prowlarr.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."proxy" = {
    image = "docker.io/traefik:v3.3.5";
    environment = {
      "CF_API_EMAIL" = "elliott.chalford@gmail.com";
      "CF_API_KEY_FILE" = "/key";
    };
    volumes = [
      "/etc/broad/proxy/cloudflare:/key:ro"
      "/etc/broad/proxy/config.yaml:/etc/traefik/traefik.yml:ro"
      "/etc/broad/proxy/routes.yaml:/etc/traefik/dynamic.yml:ro"
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "data-proxy:/data:rw"
    ];
    ports = [
      "80:80/tcp"
      "443:443/tcp"
      "8443:8443/tcp"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Network";
      "homepage.href" = "https://proxy.beannet.app";
      "homepage.icon" = "traefik";
      "homepage.name" = "Proxy";
      "homepage.siteMonitor" = "https://proxy.beannet.app";
      "homepage.widget.type" = "traefik";
      "homepage.widget.url" = "http://proxy:8080";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.auth.forwardauth.address" = "http://auth:9091/api/verify?rd=https://auth.beannet.app:8443";
      "traefik.http.middlewares.auth.forwardauth.authResponseHeaders" = "Remote-User,Remote-Groups,Remote-Name,Remote-Email";
      "traefik.http.middlewares.auth.forwardauth.trustForwardHeader" = "true";
      "traefik.http.services.proxy.loadbalancer.server.port" = "8080";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "auth"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1"
      "--network-alias=proxy"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-proxy" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-proxy.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-proxy.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "docker.io/linuxserver/qbittorrent:20.04.1";
    volumes = [
      "/etc/broad/qbittorrent/config.conf:/config/qBittorrent.conf:rw"
      "/etc/broad/qbittorrent/vuetorrent:/vuetorrent:rw"
      "/etc/localtime:/etc/localtime:ro"
      "data-qbittorrent:/config:rw"
      "media-downloads:/mnt/downloads:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Media";
      "homepage.href" = "https://qbittorrent.beannet.app";
      "homepage.icon" = "qbittorrent";
      "homepage.name" = "qBittorrent";
      "homepage.siteMonitor" = "https://qbittorrent.beannet.app";
      "homepage.widget.password" = "{{HOMEPAGE_FILE_QBITTORRENT_PASSWORD}}";
      "homepage.widget.type" = "qbittorrent";
      "homepage.widget.url" = "http://vpn:8080";
      "homepage.widget.username" = "admin";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-qbittorrent.plugin.themepark.app" = "vuetorrent";
      "traefik.http.middlewares.theme-qbittorrent.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.qbittorrent.middlewares" = "theme-qbittorrent";
      "traefik.http.services.qbittorrent.loadbalancer.server.port" = "8080";
      "wud.tag.exclude" = "^\\\\d\\\\d\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "vpn"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1"
      "--network=container:vpn"
    ];
  };
  systemd.services."podman-qbittorrent" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-volume-data-qbittorrent.service"
      "podman-volume-media-downloads.service"
    ];
    requires = [
      "podman-volume-data-qbittorrent.service"
      "podman-volume-media-downloads.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."radarr" = {
    image = "docker.io/linuxserver/radarr:5.21.1";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-radarr:/config:rw"
      "media-downloads:/mnt/downloads:rw"
      "media-movies:/mnt/movies:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Media";
      "homepage.href" = "https://radarr.beannet.app";
      "homepage.icon" = "radarr";
      "homepage.name" = "Radarr";
      "homepage.siteMonitor" = "https://radarr.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_RADARR_KEY}}";
      "homepage.widget.type" = "radarr";
      "homepage.widget.url" = "http://radarr:7878";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-radarr.plugin.themepark.app" = "radarr";
      "traefik.http.middlewares.theme-radarr.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.radarr.middlewares" = "theme-radarr";
      "traefik.http.services.radarr.loadbalancer.server.port" = "7878";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:7878 || exit 1"
      "--network-alias=radarr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-radarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-radarr.service"
      "podman-volume-media-downloads.service"
      "podman-volume-media-movies.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-radarr.service"
      "podman-volume-media-downloads.service"
      "podman-volume-media-movies.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."recyclarr" = {
    image = "docker.io/recyclarr/recyclarr:7.4.1";
    volumes = [
      "/etc/broad/recyclarr/config.yaml:/config/recyclarr.yml:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "radarr"
      "sonarr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=recyclarr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-recyclarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."romm" = {
    image = "docker.io/rommapp/romm:3.8.2";
    environment = {
      "DB_HOST" = "romm-db";
      "DB_USER" = "romm-user";
    };
    environmentFiles = [
      "/etc/broad/romm/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-romm:/redis-data:rw"
      "games-assets:/romm/assets:rw"
      "games-library:/romm/library:rw"
      "games-resources:/romm/resources:rw"
      "temp-romm:/romm/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Main";
      "homepage.href" = "https://romm.beannet.app";
      "homepage.icon" = "romm";
      "homepage.name" = "Romm";
      "homepage.siteMonitor" = "https://romm.beannet.app";
      "homepage.widget.password" = "{{HOMEPAGE_FILE_ROMM_PASSWORD}}";
      "homepage.widget.type" = "romm";
      "homepage.widget.url" = "http://romm:8080";
      "homepage.widget.username" = "admin";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.romm.loadbalancer.server.port" = "8080";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "romm-db"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:8080 || exit 1"
      "--network-alias=romm"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-romm" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-romm.service"
      "podman-volume-games-assets.service"
      "podman-volume-games-library.service"
      "podman-volume-games-resources.service"
      "podman-volume-temp-romm.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-romm.service"
      "podman-volume-games-assets.service"
      "podman-volume-games-library.service"
      "podman-volume-games-resources.service"
      "podman-volume-temp-romm.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."romm-db" = {
    image = "docker.io/linuxserver/mariadb:11.4.5";
    environment = {
      "MYSQL_DATABASE" = "romm";
      "MYSQL_USER" = "romm-user";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-romm-db:/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=romm-db"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-romm-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-romm-db.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-romm-db.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."sabnzbd" = {
    image = "docker.io/linuxserver/sabnzbd:4.5.0";
    volumes = [
      "/etc/broad/sabnzbd/config.ini:/config/sabnzbd.ini:ro"
      "/etc/localtime:/etc/localtime:ro"
      "data-sabnzbd:/config:rw"
      "media-downloads:/mnt/downloads:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Media";
      "homepage.href" = "https://sabnzbd.beannet.app";
      "homepage.icon" = "sabnzbd";
      "homepage.name" = "SABnzbd";
      "homepage.siteMonitor" = "https://sabnzbd.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_SABNZBD_KEY}}";
      "homepage.widget.type" = "sabnzbd";
      "homepage.widget.url" = "http://vpn:4321";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-sabnzbd.plugin.themepark.app" = "sabnzbd";
      "traefik.http.middlewares.theme-sabnzbd.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.sabnzbd.middlewares" = "theme-sabnzbd";
      "traefik.http.services.sabnzbd.loadbalancer.server.port" = "4321";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "vpn"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:4321 || exit 1"
      "--network=container:vpn"
    ];
  };
  systemd.services."podman-sabnzbd" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-volume-data-sabnzbd.service"
      "podman-volume-media-downloads.service"
    ];
    requires = [
      "podman-volume-data-sabnzbd.service"
      "podman-volume-media-downloads.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."scrutiny" = {
    image = "ghcr.io/analogj/scrutiny:v0.8.1-omnibus";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/run/udev:/run/udev:ro"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://scrutiny.beannet.app";
      "homepage.icon" = "scrutiny";
      "homepage.name" = "Scrutiny";
      "homepage.siteMonitor" = "https://scrutiny.beannet.app";
      "homepage.widget.type" = "scrutiny";
      "homepage.widget.url" = "http://scrutiny:8080";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.scrutiny.loadbalancer.server.port" = "8080";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+-omnibus$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--cap-add=sys_admin"
      "--cap-add=sys_rawio"
      "--health-cmd=curl -f http://localhost:8080 || exit 1"
      "--network-alias=scrutiny"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-scrutiny" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."sonarr" = {
    image = "docker.io/linuxserver/sonarr:4.0.14";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-sonarr:/config:rw"
      "media-anime:/mnt/anime:rw"
      "media-downloads:/mnt/downloads:rw"
      "media-shows:/mnt/shows:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Media";
      "homepage.href" = "https://sonarr.beannet.app";
      "homepage.icon" = "sonarr";
      "homepage.name" = "Sonarr";
      "homepage.siteMonitor" = "https://sonarr.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_SONARR_KEY}}";
      "homepage.widget.type" = "sonarr";
      "homepage.widget.url" = "http://sonarr:8989";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-sonarr.plugin.themepark.app" = "sonarr";
      "traefik.http.middlewares.theme-sonarr.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.sonarr.middlewares" = "theme-sonarr";
      "traefik.http.services.sonarr.loadbalancer.server.port" = "8989";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:8989 || exit 1"
      "--network-alias=sonarr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-sonarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-sonarr.service"
      "podman-volume-media-anime.service"
      "podman-volume-media-downloads.service"
      "podman-volume-media-shows.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-sonarr.service"
      "podman-volume-media-anime.service"
      "podman-volume-media-downloads.service"
      "podman-volume-media-shows.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."speedtest-tracker" = {
    image = "docker.io/linuxserver/speedtest-tracker:1.3.0";
    environment = {
      "APP_URL" = "https://speedtest-tracker.beannet.app";
      "DB_CONNECTION" = "sqlite";
    };
    environmentFiles = [
      "/etc/broad/speedtest-tracker/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-speedtest-tracker:/config:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.description" = "Speedtest Tracker is a self-hosted internet performance tracking application that runs speedtests using Ookla's Speedtest service.";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://speedtest-tracker.beannet.app";
      "homepage.icon" = "speedtest-tracker";
      "homepage.name" = "Speedtest Tracker";
      "homepage.siteMonitor" = "https://speedtest-tracker.beannet.app";
      "homepage.widget.type" = "speedtest";
      "homepage.widget.url" = "http://speedtest-tracker:80";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.speedtest-tracker.loadbalancer.server.port" = "80";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:80 || exit 1"
      "--network-alias=speedtest-tracker"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-speedtest-tracker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-speedtest-tracker.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-speedtest-tracker.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."tubearchivist" = {
    image = "docker.io/bbilly1/tubearchivist:v0.5.1";
    environment = {
      "ES_URL" = "http://tubearchivist-es:9200";
      "REDIS_HOST" = "tubearchivist-redis";
      "TA_AUTH_PROXY_LOGOUT_URL" = "beannet.app";
      "TA_AUTH_PROXY_USERNAME_HEADER" = "HTTP_REMOTE_USER";
      "TA_ENABLE_AUTH_PROXY" = "true";
      "TA_HOST" = "tubearchivist.beannet.app";
      "TA_USERNAME" = "admin";
    };
    environmentFiles = [
      "/etc/broad/tubearchivist/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-tubearchivist:/cache:rw"
      "media-youtube:/youtube:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Main";
      "homepage.href" = "https://tubearchivist.beannet.app";
      "homepage.icon" = "tube-archivist";
      "homepage.name" = "Tubearchivist";
      "homepage.siteMonitor" = "https://tubearchivist.beannet.app";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_TUBEARCHIVIST_KEY}}";
      "homepage.widget.type" = "tubearchivist";
      "homepage.widget.url" = "http://tubearchivist:8000";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.tubearchivist.loadbalancer.server.port" = "8000";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "tubearchivist-es"
      "tubearchivist-redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:8000 || exit 1"
      "--network-alias=tubearchivist"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-tubearchivist" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist.service"
      "podman-volume-media-youtube.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist.service"
      "podman-volume-media-youtube.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."tubearchivist-es" = {
    image = "docker.io/elasticsearch:8.17.4";
    environment = {
      "ES_JAVA_OPTS" = "-Xms1g -Xmx1g";
      "discovery.type" = "single-node";
      "path.repo" = "/usr/share/elasticsearch/data/snapshot";
      "xpack.security.enabled" = "true";
    };
    environmentFiles = [
      "/etc/broad/tubearchivist/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-tubearchivist-es:/usr/share/elasticsearch/data:rw"
    ];
    labels = {
      "kuma.__internal" = "";
      "kuma.__service" = "";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=tubearchivist-es"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-tubearchivist-es" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist-es.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist-es.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."tubearchivist-redis" = {
    image = "docker.io/redis/redis-stack-server:7.4.0-v0";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "data-tubearchivist-redis:/data:rw"
    ];
    labels = {
      "kuma.__internal" = "";
      "kuma.__service" = "";
    };
    dependsOn = [
      "tubearchivist-es"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=tubearchivist-redis"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-tubearchivist-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist-redis.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-tubearchivist-redis.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."unpackerr" = {
    image = "docker.io/golift/unpackerr:0.14.5";
    volumes = [
      "/etc/broad/unpackerr/config.conf:/config/unpackerr.conf:ro"
      "/etc/localtime:/etc/localtime:ro"
      "media-downloads:/media/downloads:rw"
    ];
    labels = {
      "autoheal" = "true";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    dependsOn = [
      "radarr"
      "sonarr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=unpackerr"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-unpackerr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-media-downloads.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-media-downloads.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."uptime-kuma" = {
    image = "docker.io/louislam/uptime-kuma:1.23.16";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "data-uptime-kuma:/app/data:rw"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://uptime-kuma.beannet.app";
      "homepage.icon" = "uptime-kuma";
      "homepage.name" = "Uptime-Kuma";
      "homepage.siteMonitor" = "https://uptime-kuma.beannet.app";
      "homepage.widget.slug" = "beannet";
      "homepage.widget.type" = "uptimekuma";
      "homepage.widget.url" = "http://uptime-kuma:3001";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.middlewares.theme-uptime-kuma.plugin.themepark.app" = "uptime-kuma";
      "traefik.http.middlewares.theme-uptime-kuma.plugin.themepark.theme" = "catppuccin-macchiato";
      "traefik.http.routers.uptime-kuma.middlewares" = "theme-uptime-kuma";
      "traefik.http.services.uptime-kuma.loadbalancer.server.port" = "3001";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -f http://localhost:3001 || exit 1"
      "--network-alias=uptime-kuma"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-uptime-kuma" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
      "podman-volume-data-uptime-kuma.service"
    ];
    requires = [
      "podman-network-broad_default.service"
      "podman-volume-data-uptime-kuma.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."vpn" = {
    image = "docker.io/qmcgaw/gluetun:v3.40.0";
    environment = {
      "SERVER_CITIES" = "London";
      "SERVER_COUNTRIES" = "UK";
      "VPN_SERVICE_PROVIDER" = "mullvad";
      "VPN_TYPE" = "wireguard";
      "WIREGUARD_ADDRESSES" = "10.67.109.188/32";
    };
    environmentFiles = [
      "/etc/broad/vpn/secrets.env"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Network";
      "homepage.icon" = "gluetun";
      "homepage.name" = "VPN";
      "homepage.widget.type" = "gluetun";
      "homepage.widget.url" = "http://vpn:8000";
      "io.containers.autoupdate" = "registry";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "wud.tag.include" = "^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--cap-add=net_admin"
      "--device=/dev/net/tun:/dev/net/tun:rwm"
      "--health-cmd=/gluetun-entrypoint healthcheck"
      "--network-alias=vpn"
      "--network=broad_default"
      "--privileged"
    ];
  };
  systemd.services."podman-vpn" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };
  virtualisation.oci-containers.containers."whats-up-docker" = {
    image = "docker.io/fmartinou/whats-up-docker:6.6.1";
    environment = {
      "WUD_WATCHER_LOCAL_WATCHBYDEFAULT" = "false";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "autoheal" = "true";
      "homepage.group" = "Monitor";
      "homepage.href" = "https://whats-up-docker.beannet.app";
      "homepage.icon" = "whats-up-docker";
      "homepage.name" = "Whats Up Docker";
      "homepage.siteMonitor" = "https://whats-up-docker.beannet.app";
      "homepage.widget.type" = "whatsupdocker";
      "homepage.widget.url" = "http://whats-up-docker:3000";
      "io.containers.autoupdate" = "registry";
      "kuma.__external" = "";
      "kuma.__internal" = "";
      "kuma.__service" = "";
      "traefik.enable" = "true";
      "traefik.http.services.whats-up-docker.loadbalancer.server.port" = "3000";
      "wud.tag.include" = "^\\\\d+\\\\.\\\\d+\\\\.\\\\d+$$";
      "wud.watch" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1"
      "--network-alias=whats-up-docker"
      "--network=broad_default"
    ];
  };
  systemd.services."podman-whats-up-docker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-broad_default.service"
    ];
    requires = [
      "podman-network-broad_default.service"
    ];
    partOf = [
      "podman-compose-broad-root.target"
    ];
    wantedBy = [
      "podman-compose-broad-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-broad_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f broad_default";
    };
    script = ''
      podman network inspect broad_default || podman network create broad_default
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };

  # Volumes
  systemd.services."podman-volume-backup-volume" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect backup-volume || podman volume create backup-volume --driver=local --opt=device=/mnt/storage/backup/volumes --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-auth" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-auth || podman volume create data-auth
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-jellyfin" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-jellyfin || podman volume create data-jellyfin
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-jellyseerr" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-jellyseerr || podman volume create data-jellyseerr
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-ldap" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-ldap || podman volume create data-ldap
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-myspeed" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-myspeed || podman volume create data-myspeed
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-netalertx" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-netalertx || podman volume create data-netalertx
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-portainer" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-portainer || podman volume create data-portainer
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-prowlarr" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-prowlarr || podman volume create data-prowlarr
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-proxy" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-proxy || podman volume create data-proxy
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-qbittorrent" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-qbittorrent || podman volume create data-qbittorrent
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-radarr" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-radarr || podman volume create data-radarr
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-romm" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-romm || podman volume create data-romm
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-romm-db" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-romm-db || podman volume create data-romm-db
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-sabnzbd" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-sabnzbd || podman volume create data-sabnzbd
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-sonarr" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-sonarr || podman volume create data-sonarr
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-speedtest-tracker" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-speedtest-tracker || podman volume create data-speedtest-tracker
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-tubearchivist" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-tubearchivist || podman volume create data-tubearchivist
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-tubearchivist-es" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-tubearchivist-es || podman volume create data-tubearchivist-es
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-tubearchivist-redis" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-tubearchivist-redis || podman volume create data-tubearchivist-redis
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-data-uptime-kuma" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect data-uptime-kuma || podman volume create data-uptime-kuma
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-games-assets" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect games-assets || podman volume create games-assets --driver=local --opt=device=/mnt/storage/games/assets --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-games-library" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect games-library || podman volume create games-library --driver=local --opt=device=/mnt/storage/games/library --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-games-resources" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect games-resources || podman volume create games-resources --driver=local --opt=device=/mnt/storage/games/resources --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-media-anime" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect media-anime || podman volume create media-anime --driver=local --opt=device=/mnt/storage/media/anime --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-media-downloads" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect media-downloads || podman volume create media-downloads --driver=local --opt=device=/mnt/storage/media/downloads --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-media-movies" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect media-movies || podman volume create media-movies --driver=local --opt=device=/mnt/storage/media/movies --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-media-shows" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect media-shows || podman volume create media-shows --driver=local --opt=device=/mnt/storage/media/shows --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-media-youtube" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect media-youtube || podman volume create media-youtube --driver=local --opt=device=/mnt/storage/media/youtube --opt=o=bind --opt=type=none
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-temp-auth" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect temp-auth || podman volume create temp-auth
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-temp-buildarr" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect temp-buildarr || podman volume create temp-buildarr
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-temp-netalertx" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect temp-netalertx || podman volume create temp-netalertx
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };
  systemd.services."podman-volume-temp-romm" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect temp-romm || podman volume create temp-romm
    '';
    partOf = [ "podman-compose-broad-root.target" ];
    wantedBy = [ "podman-compose-broad-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-broad-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
