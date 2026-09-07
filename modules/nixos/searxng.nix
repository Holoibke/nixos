{ pkgs, inputs, username, ... }:

let
  stockCss = "${inputs.searxng}/searx/static/themes/simple/sxng-ltr.min.css";

  themeSkeleton = pkgs.runCommand "sxng-ltr.min.css.template" { }
    ''
      cat ${stockCss} > $out
      printf '\n' >> $out
      cat ${./searxng-theme.css} >> $out
    '';

  renderTheme = pkgs.writers.writePython3Bin "searxng-render-theme" { }
    (builtins.readFile ./searxng-render-theme.py);

  walDir = "/home/${username}/.cache/wal";
  walColorsFile = "${walDir}/colors.json";

  themeDir = "/var/lib/searxng-theme";
  themeCss = "${themeDir}/sxng-ltr.min.css";
  themeCssTarget = "/usr/local/searxng/searx/static/themes/simple/sxng-ltr.min.css";
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/searxng 0750 root root -"
    "d ${themeDir} 0755 root root -"
  ];

  systemd.services.searxng-theme-render = {
    description = "Render SearXNG theme from the pywal palette";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${renderTheme}/bin/searxng-render-theme ${walColorsFile} ${themeSkeleton} ${themeDir} ${pkgs.brotli}/bin/brotli ${pkgs.systemd}/bin/systemctl docker-searxng.service";
    };
  };

  systemd.paths.searxng-theme-render = {
    description = "Watch the pywal palette for changes";
    wantedBy = [ "multi-user.target" ];
    pathConfig = {
      PathModified = walColorsFile;
      PathChanged = walDir;
      Unit = "searxng-theme-render.service";
    };
  };

  virtualisation.oci-containers.containers.searxng = {
    image = "docker.io/searxng/searxng:latest";
    autoStart = true;

    ports = [ "127.0.0.1:8080:8080" ];

    volumes = [
      "/var/lib/searxng:/etc/searxng:rw"
      "${themeCss}:${themeCssTarget}:ro"
      "${themeCss}.gz:${themeCssTarget}.gz:ro"
      "${themeCss}.br:${themeCssTarget}.br:ro"
    ];

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

  systemd.services.docker-searxng = {
    wants = [ "searxng-theme-render.service" ];
    after = [ "searxng-theme-render.service" ];
  };
}
