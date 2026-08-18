{ config, pkgs, lib, inputs, username, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default

    ./programs/noctalia.nix
    ./programs/kitty.nix
    ./programs/git.nix
    ./programs/textfox.nix
    ./programs/cursor-theme.nix

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
  ];
}
