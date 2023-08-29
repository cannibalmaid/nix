{ inputs }: {

  imports = [
    inputs.home-manager.nixos
    inputs.hyprland.homeManagerModules.default
  ];

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
    ];

  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };


}
