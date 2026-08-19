{ ... }:

{
  home.file.".config/hypr/hyprland.lua".source = ./lua/hyprland.lua;

  home.file.".config/hypr/config" = {
    source = ./lua/config;
    recursive = true;
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./lua/hyprpaper.conf;
  home.file.".config/hypr/hypridle.conf".source = ./lua/hypridle.conf;
}
