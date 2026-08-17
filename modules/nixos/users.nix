{ pkgs, username, ... }:

{
  programs.fish.enable = true;

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
    shell = pkgs.fish;
    initialPassword = "changeme"; # run `passwd` after first login
  };
}
