{ ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        # must be set before thunderbird ever creates its "Local Folders"
        # account or it defaults to mbox instead this needs to match the
        # maildir format getmail6 writes to ~/Mail/disroot (see getmail.nix)
        "mail.serverDefaultStoreContractID" = "@mozilla.org/msgstore/maildirstore;1";
      };
    };
  };
}
