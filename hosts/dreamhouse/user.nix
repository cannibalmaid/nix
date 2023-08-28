{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    outputs.homeManagerModules.presence
    outputs.homeManagerModules.arrpc

    ../../modules/home-manager/hyprland
  ];

  home = {
    homeDirectory = "/home/ammy";

    packages = with pkgs; [
      librewolf
      neovim
      lutris
      (webcord-vencord.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
        postInstall = oldAttrs.postInstall or "" + ''
          wrapProgram $out/bin/webcord \
          --add-flags "--ozone-platform-hint=auto"
        '';
      }))
      wezterm
      vscodium
      kitty
      kodi-wayland
      swayosd
      libnotify
      grim
      slurp
      gopass
      discord-canary
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

      itch


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

      killall

      gnome-text-editor

      heroic
    ];
  };

  services.arrpc.enable = true;
  services.linux-discord-rich-presence.enable = true;

  gtk = {
    enable = true;
    font.name = "San Francisco Text 10";

    theme = {
      name = "Catppuccin";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "pink"; };
    };

    cursorTheme = {
      name = "Qogir-Recolored-Catppuccin-Pink";
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.stateVersion = "23.05";
}
