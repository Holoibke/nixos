{ ... }:

let
  gitPrivate = import ../../../git-private.nix;
in
{
  programs.git = {
    enable = true;
    settings.user = {
      name = "gitPrivate.name";
      email = "gitPrivate.email";
    };
  };
}
