{ config, lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/AA63-0E13";
      fsType = "vfat";
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=swap" "compress=zstd" "noatime" ];
    };

  fileSystems."/games" =
    {
      device = "/dev/disk/by-uuid/040d115e-4dbd-4768-bb05-f9409cc213fa";
      fsType = "btrfs";
      options = [ "subvol=games" "compress=zstd" "noatime" ];
    };

  fileSystems."/games/launchers/nvme" =
    {
      device = "/dev/disk/by-uuid/51fb66dc-aeea-403d-80ee-23df56049d30";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };

  fileSystems."/games/launchers/ssd" =
    {
      device = "/dev/disk/by-uuid/90866b4c-23ab-4d39-8f12-2d86829d0090";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };


  fileSystems."/games/launchers/hhd" =
    {
      device = "/dev/disk/by-uuid/a88d71c5-4412-4435-9adf-7330b52571da";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };


  swapDevices = [{
    device = "/swap/swapfile";
    size = 16 * 1024;
  }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.enableAllFirmware = true;
}

