{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Nerd Font Mono";
      size = 11;
    };
    settings = {
      background_opacity = "0.6";
      cursor_trail = "1";
      window_padding_width = "25";
    };
  };
}
