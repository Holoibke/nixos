{ config, pkgs, lib, inputs, username, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    # programs
    ./programs/noctalia.nix
    ./programs/kitty.nix
    ./programs/git.nix
    ./programs/textfox.nix
    ./programs/cursor-theme.nix
    ./programs/vscodium.nix
    ./programs/thunderbird.nix
    ./programs/getmail.nix
    #configs
    ../configs/fastfetch
    ../configs/hyprland
    ../configs/fish
    ../configs/dolphin
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bottles
    krita
    prismlauncher
    equibop
    lmstudio
    onlyoffice-desktopeditors
    vscodium
    thunderbird
    r2modman
    getmail6
    rmpc
  ];
}
