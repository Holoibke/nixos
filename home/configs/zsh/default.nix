{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autocd = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      expireDuplicatesFirst = true;
    };

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

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MOZ_ENABLE_WAYLAND = "1";
      # SDL_VIDEODRIVER = "wayland";
      NIXOS_OZONE_WL = "1";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };

    initContent = ''
      # ~/.local/bin on PATH (once)
      case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) export PATH="$HOME/.local/bin:$PATH" ;;
      esac

      # only show fastfetch in interactive shells
      if [[ -o interactive ]]; then
        fastfetch
      fi
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
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 500;
      # keep the prompt small: defaults are already fasttrim the noise
      line_break.disabled = false;
    };
  };
}