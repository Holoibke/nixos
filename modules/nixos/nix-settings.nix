{ ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    flake-registry = "";

    # Binary caches
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
  nix.channel.enable = false;
}
