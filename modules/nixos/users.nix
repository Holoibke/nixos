{ pkgs, username, ... }:

{
  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "gamemode"
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme"; # run `passwd` after first login
  };
}
