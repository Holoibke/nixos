{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default.userSettings = {
      "editor.fontFamily" = "'Iosevka Nerd Font Mono', monospace";
      "editor.fontLigatures" = true;
      "terminal.integrated.fontFamily" = "'Iosevka Nerd Font Mono', monospace";
    };
  };
}
