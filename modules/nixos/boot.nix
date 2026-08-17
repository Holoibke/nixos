{ pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # CachyOS kernel zen4 version
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

  # AMD CPU
  boot.kernelParams = [ "amd_pstate=active" ];

  boot.extraModprobeConfig = ''
    options rtw89_pci disable_clkreq=y
    options rtw89_core disable_ps_mode=y
    options rtw89_8852be disable_ps_mode=y
  '';
}
