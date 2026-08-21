{ pkgs, ... }:

let
  mailPrivate = import /home/holibken/.config/credentials/mail;
in
{
  home.packages = [ pkgs.getmail6 ];

  systemd.user.tmpfiles.rules = [ "d %h/Mail 0700 - - - -" ];

  xdg.configFile."getmail/getmailrc".text = ''
    [retriever]
    type = SimplePOP3SSLRetriever
    server = disroot.org
    port = 995
    # username = ${mailPrivate.username}
    password_command = ("cat", "/home/holibken/.config/getmail/disroot.pass")

    [destination]
    type = Maildir
    path = ~/Mail/disroot/

    [options]
    # flip delete to true once you trust it, if you want disroots own inbox to empty out as mail lands locally
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
