{ inputs, pkgs, home-manager, lib, ... }: {

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

      gamescope
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };



}
