{ pkgs, ... }:

{
  xdg.enable = true;
  xdg.mime.enable = true;

  xdg.configFile."menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  home.sessionVariables.XDG_MENU_PREFIX = "plasma-";
}
