{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    outputs.homeManagerModules.presence
    outputs.homeManagerModules.arrpc
  ];

  home = {
    homeDirectory = "/home/ammy";

    packages = with pkgs; [
      librewolf
      neovim
      (webcord-vencord.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
        postInstall = oldAttrs.postInstall or "" + ''
          wrapProgram $out/bin/webcord \
          --add-flags "--ozone-platform-hint=auto"
        '';
      }))
      wezterm
      vscodium
      kodi-wayland
      gopass
      gnome-text-editor
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

  qtTheme = {
    name = "Catppuccin-Mocha-Mauve";
    package = pkgs.catppuccin-kvantum.override {
      variant = "Mocha";
      accent = "Mauve";
    };
  };

  fonts = {
    default = {
      name = "SpaceMono Nerd Font";
      size = "12";
    };
    # iconFont = {
    #   name = "Liga SFMono Nerd Font";
    #   package = pkgs.sf-pro-fonts;
    # };
    # monospace = {
    #   name = "MesloLGSDZ Nerd Font Mono";
    #   package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
    # };
    # emoji = {
    #   name = "Joypixels";
    #   package = pkgs.joypixels;
    # };
  };



  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.stateVersion = "23.05";
}
