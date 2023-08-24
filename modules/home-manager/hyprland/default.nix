{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
 # imports = [./config.nix];

  home.packages = with pkgs; [
    seatd
    jaq
    xorg.xprop
    dunst
    wofi
    gnome.nautilus
    swww
    eww-wayland
    socat
    jq
    procps
    pamixer
    pulseaudio
    playerctl
    ripgrep
    # inputs'.hyprland-contrib.packages.grimblast
    # self'.packages.xwaylandvideobridge
  ];

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  # enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.enableNvidiaPatches = true;
  #services.xserver.displayManager.sessionPackages = [ ''wayland.windowManager.hyprland.package'' ];
}
