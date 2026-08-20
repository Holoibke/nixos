{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#Mieszko-II-Lambert --impure";
      nrb = "sudo nixos-rebuild build --flake /etc/nixos#Mieszko-II-Lambert --impure";
      ncg = "nix-collect-garbage -d";
      nsp = "nix-shell -p";
      fl = "cd /etc/nixos && ls";

      c = "clear";
      q = "exit";
      ".." = "cd ..";
      "..." = "cd ../..";

      g = "git";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gs = "git status";
      gl = "git log --oneline --graph";

      cat = "bat";
      ls = "eza --icons --group-directories-first";
      ll = "eza -la --icons --group-directories-first";
      lt = "eza --tree --icons --group-directories-first";
      vim = "nvim";
      vi = "nvim";

      h = "hyprctl";
      hc = "hyprctl dispatch";
    };

    shellInit = ''
      set -g fish_greeting
      fish_add_path ~/.local/bin
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx MOZ_ENABLE_WAYLAND 1
      # --set -gx SDL_VIDEODRIVER wayland
      set -gx NIXOS_OZONE_WL 1
      set -gx XCURSOR_SIZE 24
      set -gx XCURSOR_THEME Bibata-Modern-Ice
    '';

    interactiveShellInit = ''
      if status is-interactive
        fastfetch
      end
    '';
  };

  home.packages = with pkgs; [
    eza
    bat
    fd
    ripgrep
    fzf
    zoxide
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
