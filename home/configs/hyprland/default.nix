{ ... }:

{
  home.file.".config/hypr/hyprland.lua".source = ./lua/hyprland.lua;

  # `recursive = true` copies the directory's contents directly instead of
  # symlinking the whole ./lua/config dir — lets you drop other files into
  # ~/.config/hypr/config later without home-manager fighting you over it.
  home.file.".config/hypr/config" = {
    source = ./lua/config;
    recursive = true;
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./lua/hyprpaper.conf;
  home.file.".config/hypr/hypridle.conf".source = ./lua/hypridle.conf;
}
