{ pkgs, ... }:

let
  mailPrivate = import /home/holibken/.config/credentials/mail;
  extractMailPassword = pkgs.writeShellScript "extract-mail-password" ''
    sed -n 's/^[[:space:]]*password = "\(.*\)";.*/\1/p' "$1"
  '';
in
{
  home.packages = [ pkgs.getmail6 ];

  systemd.user.tmpfiles.rules = [
    "d %h/Mail 0700 - - - -"
    "d %h/.getmail 0700 - - - -"
  ];

  xdg.configFile."getmail/getmailrc".text = ''
    [retriever]
    type = SimplePOP3SSLRetriever
    server = disroot.org
    port = 995
    username = ${mailPrivate.username}
    password_command = ("${extractMailPassword}", "/home/holibken/.config/credentials/mail")

    [destination]
    type = Maildir
    path = ~/Mail/disroot/

    [options]
    # Starting conservative: nothing gets deleted from the server until
    # you've confirmed this actually works reliably. Flip delete to true
    # once you trust it, if you want Disroot's own inbox to empty out as
    # mail lands locally.
    read_all = true
    delete = false
    verbose = 1
    message_log = ~/.getmail/disroot.log
  '';
  
  systemd.user.services.getmail-disroot = {
    Unit.Description = "Fetch Disroot mail via getmail6";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.getmail6}/bin/getmail";
    };
  };

  systemd.user.timers.getmail-disroot = {
    Unit.Description = "Periodic Disroot mail fetch";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "10m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}