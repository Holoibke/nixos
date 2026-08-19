{ username, ... }:

{
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-content";
      };
      wallpaper = {
        enabled = true;
        default.path = "/home/${username}/Pictures/Wallpapers/default.jpg";
      };
      shell = {
        font_family = "Iosevka Nerd Font Mono";
        greeter_sync.auto_sync = true;
      };
    };
  };
}
