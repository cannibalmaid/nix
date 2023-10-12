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
  ];

  home = {
    homeDirectory = "/home/ammy";

    packages = with pkgs; [
      webcord-vencord
      unstable.wezterm
      vscodium
      unstable.kodi-wayland
      gopass
      gnome-text-editor

      gnome.file-roller
      rar
      presence

      pavucontrol
    ];
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin-mocha;
    colorScheme = "flamingo";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
    ];
  };

  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        #package = pkgs.neovim-unwrapped; # this is the default value, but I can use the nightly overlay on demand
        viAlias = true;
        vimAlias = true;
        enableEditorconfig = true;
        preventJunkFiles = true;
        enableLuaLoader = true;

        lineNumberMode = "number";

        treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          lua
          markdown
          markdown-inline
        ];

        extraPlugins = with pkgs.vimPlugins; {
          aerial = {
            package = aerial-nvim;
            setup = "require('aerial').setup {}";
          };

          harpoon = {
            package = harpoon;
            setup = "require('harpoon').setup {}";
            after = [ "aerial" ];
          };

          nvim-surround = {
            package = nvim-surround;
            setup = "require('nvim-surround').setup{}";
          };

          htms = {
            package = htms;
            after = [ "treesitter" ];
          };

          regexplainer = {
            package = regexplainer;
          };
        };

        debugMode = {
          enable = false;
          logFile = "/tmp/nvim.log";
        };
      };

      vim.lsp = {
        formatOnSave = true;
        lspkind.enable = true;
        lsplines.enable = true;
        lightbulb.enable = true;
        lspsaga.enable = false;
        lspSignature.enable = true;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
      };

      vim.debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      vim.languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        html.enable = true;
        sql.enable = true;
        java.enable = true;
        ts.enable = true;
        go.enable = true;
        python.enable = true;
        zig.enable = true;
        dart.enable = true;
        elixir.enable = false;
        svelte.enable = true;

        rust = {
          enable = true;
          crates.enable = true;
        };

        clang = {
          enable = true;
          lsp.server = "clangd";
        };
      };

      vim.visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
        cellularAutomaton.enable = true;
        fidget-nvim.enable = true;

        indentBlankline = {
          enable = true;
          fillChar = null;
          eolChar = null;
          showCurrContext = true;
        };

        cursorline = {
          enable = true;
          lineTimeout = 0;
        };
      };

      vim.statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.filetree = {
        nvimTree = {
          enable = true;
          openOnSetup = true;
          disableNetrw = true;

          hijackUnnamedBufferWhenOpening = true;
          hijackCursor = true;
          hijackDirectories = {
            enable = true;
            autoOpen = true;
          };

          git = {
            enable = true;
            showOnDirs = false;
            timeout = 100;
          };

          view = {
            preserveWindowProportions = false;
            cursorline = false;
            width = {
              min = 35;
              max = -1;
              padding = 1;
            };
          };

          renderer = {
            indentMarkers.enable = true;
            rootFolderLabel = false;

            icons = {
              modifiedPlacement = "after";
              gitPlacement = "after";
              show.git = true;
              show.modified = true;
            };
          };

          diagnostics.enable = true;

          modified = {
            enable = true;
            showOnDirs = false;
            showOnOpenDirs = true;
          };

          mappings = {
            toggle = "<C-w>";
          };
        };
      };

      vim.tabline = {
        nvimBufferline.enable = true;
      };

      vim.treesitter.context.enable = true;

      vim.binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      vim.telescope.enable = true;

      vim.git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions = false;
      };

      vim.minimap = {
        # cool for vanity but practically useless on small screens
        minimap-vim.enable = false;
        codewindow.enable = true;
      };

      vim.dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = true;
      };

      vim.notify = {
        nvim-notify.enable = true;
      };

      vim.projects = {
        project-nvim = {
          enable = true;
        };
      };

      vim.utility = {
        ccc.enable = true;
        vim-wakatime.enable = true;
        icon-picker.enable = true;
        surround.enable = true;
        diffview-nvim.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      vim.notes = {
        obsidian.enable = false;
        orgmode.enable = false;
        mind-nvim.enable = true;
        todo-comments.enable = true;
      };

      vim.terminal = {
        toggleterm = {
          mappings.open = "<C-t>";
          enable = true;
          lazygit.enable = true;
        };
      };

      vim.ui = {
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false;
        illuminate.enable = true;

        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };

        smartcolumn = {
          enable = true;
          columnAt.languages = {
            markdown = 80;
            nix = 110;
            ruby = 120;
            java = 130;
            go = [ 90 130 ];
          };
        };

        borders = {
          enable = true;
          globalStyle = "rounded";
        };
      };

      vim.assistant = {
        copilot = {
          enable = true;
          cmp.enable = true;
        };
      };

      vim.session = {
        nvim-session-manager = {
          enable = false;
        };
      };

      vim.gestures = {
        gesture-nvim.enable = false;
      };

      vim.comments = {
        comment-nvim.enable = true;
      };

      vim.presence = {
        presence-nvim = {
          enable = true;
          auto_update = true;
          image_text = "The Superior Text Editor";
          client_id = "793271441293967371";
          main_image = "neovim";
          show_time = true;
          rich_presence = {
            editing_text = "Editing %s";
          };
        };
      };
    };
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

  gtk = {
    enable = true;
    font.name = "San Francisco Text 10";

    theme = {
      name = "Catppuccin";
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
