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

      stremio

      vulkan-tools
      glxinfo

      cherry-mesa.mesa
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

  ## Kitty
  programs.kitty = {
    enable = true;
    font = {
      name = "CascadiaCode";
      package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
      size = 12.5;
    };

    theme = "Catppuccin-Mocha";
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_selection";
      "ctrl+t" = "new_window";
      "ctrl+w" = "close_window";
      "ctrl+alt+a" = "previous_window";
      "ctrl+alt+d" = "next_window";
      "alt+r" = "start_resizing_window";
    };

    settings = {
      enable_audio_bell = false;
      repaint_delay = 8;
      window_padding_width = 20;
      strip_trailing_spaces = "smart";
      confirm_os_window_close = 0;

      "mouse_map left click ungrabbed mouse_handle_click" = "selection link prompt";
    };
  };

  ## Fish
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
      neofetch
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = "[](#9A348E)$os$username[](bg:#DA627D fg:#9A348E)$directory[](fg:#DA627D bg:#FCA17D)$git_branch$git_status[](fg:#FCA17D bg:#86BBD8)$c$nodejs$rust[](fg:#86BBD8 bg:#06969A)$docker_context[](fg:#06969A bg:#33658A)$time[](fg:#33658A) ";
      scan_timeout = 10;

      username = {
        show_always = true;
        style_user = "bg:#9A348E";
        style_root = "bg:#9A348E";
        format = "[$user ]($style)";
        disabled = false;
      };

      os = {
        style = "bg:#9A348E";
        disabled = true; # Disabled by default
      };

      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };

      c = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";

      };

      git_status = {
        style = "bg:#FCA17D";
        format = "[ $all_status$ahead_behind ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";

      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#33658A";
        format = "[ ♥ $time ]($style)";
      };
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
