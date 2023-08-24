{ config, pkgs, ... }:

#   ▄████  ██▀███   █    ██  ▄▄▄▄   
#  ██▒ ▀█▒▓██ ▒ ██▒ ██  ▓██▒▓█████▄ 
# ▒██░▄▄▄░▓██ ░▄█ ▒▓██  ▒██░▒██▒ ▄██
# ░▓█  ██▓▒██▀▀█▄  ▓▓█  ░██░▒██░█▀  
# ░▒▓███▀▒░██▓ ▒██▒▒▒█████▓ ░▓█  ▀█▓
#  ░▒   ▒ ░ ▒▓ ░▒▓░░▒▓▒ ▒ ▒ ░▒▓███▀▒
#   ░   ░   ░▒ ░ ▒░░░▒░ ░ ░ ▒░▒   ░ 
# ░ ░   ░   ░░   ░  ░░░ ░ ░  ░    ░ 
#       ░    ░        ░      ░      
#                                 ░ 

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
    enable = true;
    copyKernels = true;
    efiInstallAsRemovable = true;
    efiSupport = true;
    fsIdentifier = "uuid";
    splashMode = "stretch";
    device = "nodev";
    extraEntries = ''
      		menuentry "Reboot" {
      			reboot
      		}
      		'';
  };
}
