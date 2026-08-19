{ ... }:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/searxng 0750 root root -"
  ];

  virtualisation.oci-containers.containers.searxng = {
    image = "docker.io/searxng/searxng:latest";
    autoStart = true;

    ports = [ "127.0.0.1:8080:8080" ];

    volumes = [ "/var/lib/searxng:/etc/searxng:rw" ];

    environment = {
      SEARXNG_BASE_URL = "http://localhost:8080/";
      INSTANCE_NAME = "searxng";
    };

    extraOptions = [
      "--cap-drop=ALL"
      "--cap-add=CHOWN"
      "--cap-add=SETGID"
      "--cap-add=SETUID"
      "--cap-add=DAC_OVERRIDE"
    ];
  };
}