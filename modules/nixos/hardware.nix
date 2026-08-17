{ pkgs, ... }:

{
  hardware.cpu.amd.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-validation-layers
    ];
  };

  # AMD GPU (RX 9060XT)
  services.xserver.videoDrivers = [ "amdgpu" ];

  # ROCm/OpenCL support
  hardware.amdgpu.opencl.enable = true;
  hardware.amdgpu.initrd.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  services.fstrim.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
}
