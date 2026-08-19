{ config, pkgs, lib, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
    inputs.home-manager.nixosModules.default

    ../../modules/nixos/nix-settings.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/nix-ld.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/affinity.nix
    ../../modules/nixos/racing-wheel.nix
    ../../modules/nixos/docker.nix
    ../../modules/home-manager
  ];

  networking.hostName = "Mieszko-II-Lambert";

  nixpkgs.config.allowUnfree = true;

  # Bump only after reading the release notes:
  # https://nixos.org/manual/nixos/stable/release-notes
  system.stateVersion = "25.11";
}
