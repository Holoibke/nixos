{ config, pkgs, ... }:

let

  wheelKernelPackages = pkgs.linuxPackagesFor config.boot.kernelPackages.kernel;
in
{
  boot.extraModulePackages = [ wheelKernelPackages.hid-tmff2 ];
  boot.kernelModules = [ "hid-tmff2" ];

  boot.blacklistedKernelModules = [ "hid_thrustmaster" ];
  services.udev.packages = [ wheelKernelPackages.hid-tmff2 ];

  environment.systemPackages = [ pkgs.oversteer ];

  boot.extraModprobeConfig = ''
    options hid-tmff-new open_mode=0
    options hid-tmff-new timer_msecs=2
  '';
}
