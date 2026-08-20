{ ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 ];
  networking.extraHosts = ''
    127.0.0.1 searxng.local
  '';

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };
}
