{ ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };
}
