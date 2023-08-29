{ inputs, pkgs, home-manager, lib, ... }: {

  home-manager.users.ammy = {
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

    systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;
  services.xserver.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.configFile."hyprlandgay".source = ./config;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };


}
