{ config, pkgs, inputs, ... }:

let

  stockCss = "${inputs.searxng}/searx/static/themes/simple/sxng-ltr.min.css";

  themeCss = pkgs.runCommand "sxng-ltr.min.css" { } ''
    cat ${stockCss} > $out
    printf '\n' >> $out
    cat ${./searxng-theme.css} >> $out
  '';

  themeCssGz = pkgs.runCommand "sxng-ltr.min.css.gz" {
    nativeBuildInputs = [ pkgs.gzip ];
  } ''
    gzip -9 -n -c ${themeCss} > $out
  '';

  themeCssBr = pkgs.runCommand "sxng-ltr.min.css.br" {
    nativeBuildInputs = [ pkgs.brotli ];
  } ''
    brotli -q 11 -c ${themeCss} > $out
  '';

  themeCssTarget = "/usr/local/searxng/searx/static/themes/simple/sxng-ltr.min.css";
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/searxng 0750 root root -"
  ];

  virtualisation.oci-containers.containers.searxng = {
    image = "docker.io/searxng/searxng:latest";
    autoStart = true;

    ports = [ "127.0.0.1:8080:8080" ];

    volumes = [
      "/var/lib/searxng:/etc/searxng:rw"
      "${themeCss}:${themeCssTarget}:ro"
      "${themeCssGz}:${themeCssTarget}.gz:ro"
      "${themeCssBr}:${themeCssTarget}.br:ro"
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
}
