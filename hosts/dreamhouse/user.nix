{ inputs
, outputs
, lib
, config
, pkgs
, spicetify-nix
, neovim-flake
, ...
}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  htms = pkgs.fetchFromGitHub {
    owner = "calops";
    repo = "hmts.nvim";
    rev = "v0.1.0";
    hash = "sha256-SBNTtuzwSmGgwALD/JqLwXGLow+Prn7dJrQNODPeOAY=";
  };

  regexplainer = pkgs.fetchFromGitHub {
    owner = "bennypowers";
    repo = "nvim-regexplainer";
    rev = "4250c8f3c1307876384e70eeedde5149249e154f";
    hash = "sha256-15DLbKtOgUPq4DcF71jFYu31faDn52k3P1x47GL3+b0=";
  };
in
{
  imports = [
    outputs.homeManagerModules.presence
    outputs.homeManagerModules.arrpc
    outputs.homeManagerModules.swww
    outputs.homeManagerModules.swww-random

    inputs.spicetify-nix.homeManagerModule
    inputs.neovim-flake.homeManagerModules.default

    outputs.homeManagerModules.librewolf
  ];

  home = {
    homeDirectory = "/home/ammy";

    packages = with pkgs; [
      webcord-vencord
      nwg-look
      kitty
      vscodium
      kodi-wayland
      gopass
      gnome-text-editor

      gnome.file-roller
      rar
      presence
      foot

      pavucontrol
      xwaylandvideobridge
      discord-canary
    ];
  };



  #  programs.spicetify = {
  #    enable = true;
  #    theme = spicePkgs.themes.catppuccin-mocha;
  #    colorScheme = "flamingo";

  #    enabledExtensions = with spicePkgs.extensions; [
  #      fullAppDisplay
  #      shuffle # shuffle+ (special characters are sanitized out of ext names)
  #    ];
  #  };

  programs.neovim-flake = {
    enable = true;
  };

  services.arrpc.enable = true;
  # services.linux-discord-rich-presence.enable = true;
  services.swww.enable = true;
  services.swww-random.enable = true;

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

  home.file.".config/fish/themes/CatppuccinMocha.theme" = {
    source = ../../files/fish/CatppuccinMocha.theme;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config theme choose CatppuccinMocha
      export EDITOR=nvim
      # Set PATH to add .local/bin
      #export PATH="$PATH:/home/nintron/.local/bin"
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
    };
  };


  gtk = {
    enable = true;
    font.name = "San Francisco Text 10";

    theme = {
      name = "Catppuccin-Mocha-Standard-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "pink";
      };
    };

    cursorTheme = {
      name = "Qogir-Recolored-Catppuccin-Pink";
      size = 24;
    };
  };



  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home.stateVersion = "23.11";
}
