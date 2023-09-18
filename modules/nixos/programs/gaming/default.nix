{ inputs, pkgs, home-manager, lib, ... }:

{
  imports = [
    inputs.aagl.nixosModules.default

  ];

  home-manager.users.ammy = {
    home.packages = with pkgs; [
      unstable.heroic
      itch
      unstable.lutris
      unstable.protonup-qt

      unstable.steamtinkerlaunch
      unzip
      xdotool
      xorg.xwininfo
      unixtools.xxd

      unstable.grapejuice
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;

  programs.honkers-railway-launcher.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };



}
