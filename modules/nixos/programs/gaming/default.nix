{ inputs, pkgs, home-manager, lib, ... }:

{
  imports = [
    inputs.aagl.nixosModules.default
  ];

  home-manager.users.ammy = {
    home.packages = with pkgs; [
      heroic
      itch
      lutris
      protonup-qt

      steamtinkerlaunch
      unzip
      xdotool
      xorg.xwininfo
      unixtools.xxd
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;

  programs.honkers-railway-launcher.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };



}
