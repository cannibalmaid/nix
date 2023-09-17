{ inputs
, outputs
, lib
, config
, pkgs
, spicetify-nix
, ...
}:

let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    outputs.homeManagerModules.presence
    outputs.homeManagerModules.arrpc
    outputs.homeManagerModules.swww
    outputs.homeManagerModules.swww-random


    inputs.spicetify-nix.homeManagerModule
  ];

  home = {
    homeDirectory = "/home/ammy";

    packages = with pkgs; [
      unstable.librewolf
      #unstable.neovim
      # (unstable.webcord-vencord.overrideAttrs (oldAttrs: {
      #   buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
      #   postInstall = oldAttrs.postInstall or "" + ''
      #     wrapProgram $out/bin/webcord \
      #     --add-flags "--ozone-platform-hint=auto"
      #   '';
      # }))
      unstable.webcord-vencord
      unstable.wezterm
      unstable.vscodium
      unstable.kodi-wayland
      gopass
      gnome-text-editor

      gnome.file-roller
      rar

      discord-canary
      presence

      gnome.gnome-software

      pavucontrol
      obinskit
    ];
  };

  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin-mocha;
      colorScheme = "flamingo";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
      ];
    };


  services.arrpc.enable = true;
  # services.linux-discord-rich-presence.enable = true;
  services.swww.enable = true;
  services.swww-random.enable = true;

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
  };

  xdg.desktopEntries = {
    nvim = {
      name = ".";
      noDisplay = true;
    };

    "org.gnome.FileRoller" = {
      name = ".";
      noDisplay = true;
    };

    btop = {
      name = ".";
      noDisplay = true;
    };

    fish = {
      name = ".";
      noDisplay = true;
    };

    steamtinkerlaunch = {
      name = ".";
      noDisplay = true;
    };
  };


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
