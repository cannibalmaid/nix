{ config
, inputs
, outputs
, pkgs
, lib
, ...
}: {

  imports = [
    ./config.nix
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    seatd
    jaq
    xorg.xprop
    dunst
    wofi
    gnome.nautilus
    swww
    unstable.eww-wayland
    socat
    jq
    procps
    pamixer
    pulseaudio
    playerctl
    ripgrep
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wtype
    swayosd
    libnotify

  ];

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];

  # enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.enableNvidiaPatches = true;

  # xdg.configFile.hyprland.test = {
  #   source = ./files/hyprland;
  #   recursive = true;
  # };

  xdg.configFile."hyprlandgay".source = ../../../files/hyprland;

  #services.xserver.displayManager.sessionPackages = [ ''wayland.windowManager.hyprland.package'' ];
}
