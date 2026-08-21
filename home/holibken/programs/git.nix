{ ... }:

let
  gitPrivate = import /home/holibken/.config/credentials/git;
in
{
  programs.git = {
    enable = true;
    settings.user = {
      name = gitPrivate.name;
      email = gitPrivate.mail;
    };
  };
}
