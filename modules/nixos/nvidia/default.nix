{ config
, pkgs
, system
, ...
}:
#  ███▄    █ ██▒   █▓ ██▓▓█████▄  ██▓ ▄▄▄
#  ██ ▀█   █▓██░   █▒▓██▒▒██▀ ██▌▓██▒▒████▄
# ▓██  ▀█ ██▒▓██  █▒░▒██▒░██   █▌▒██▒▒██  ▀█▄
# ▓██▒  ▐▌██▒ ▒██ █░░░██░░▓█▄   ▌░██░░██▄▄▄▄██
# ▒██░   ▓██░  ▒▀█░  ░██░░▒████▓ ░██░ ▓█   ▓██▒
# ░ ▒░   ▒ ▒   ░ ▐░  ░▓   ▒▒▓  ▒ ░▓   ▒▒   ▓▒█░
# ░ ░░   ░ ▒░  ░ ░░   ▒ ░ ░ ▒  ▒  ▒ ░  ▒   ▒▒ ░
#    ░   ░ ░     ░░   ▒ ░ ░ ░  ░  ▒ ░  ░   ▒
#          ░      ░   ░     ░     ░        ░  ░
#                ░        ░
{
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.powerManagement.enable = true;
}
