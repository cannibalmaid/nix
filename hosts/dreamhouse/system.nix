{ inputs, outputs, config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/grub
    ../../modules/nixos/nvidia
    ../../modules/nixos/persistence
    ../../modules/nixos/fonts
    ../../modules/nixos/networking
    ../../modules/nixos/nix
    ../../modules/nixos/shell

    ../../modules/nixos/programs/hyprland
    ../../modules/nixos/programs/gaming

    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  #  ██▓███   ██▓ ██▓███  ▓█████  █     █░ ██▓ ██▀███  ▓█████
  # ▓██░  ██▒▓██▒▓██░  ██▒▓█   ▀ ▓█░ █ ░█░▓██▒▓██ ▒ ██▒▓█   ▀
  # ▓██░ ██▓▒▒██▒▓██░ ██▓▒▒███   ▒█░ █ ░█ ▒██▒▓██ ░▄█ ▒▒███
  # ▒██▄█▓▒ ▒░██░▒██▄█▓▒ ▒▒▓█  ▄ ░█░ █ ░█ ░██░▒██▀▀█▄  ▒▓█  ▄
  # ▒██▒ ░  ░░██░▒██▒ ░  ░░▒████▒░░██▒██▓ ░██░░██▓ ▒██▒░▒████▒
  # ▒▓▒░ ░  ░░▓  ▒▓▒░ ░  ░░░ ▒░ ░░ ▓░▒ ▒  ░▓  ░ ▒▓ ░▒▓░░░ ▒░ ░
  # ░▒ ░      ▒ ░░▒ ░      ░ ░  ░  ▒ ░ ░   ▒ ░  ░▒ ░ ▒░ ░ ░  ░
  # ░░        ▒ ░░░          ░     ░   ░   ▒ ░  ░░   ░    ░
  #           ░              ░  ░    ░     ░     ░        ░  ░

  #security.rtkit.enable = true;
  #hardware.pulseaudio.enable = false;
  hardware.opentabletdriver.enable = true;
  hardware.steam-hardware.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      # enable this module      
      enable = true;
    };
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;

  #  ██████▓██   ██▓  ██████ ▄▄▄█████▓▓█████  ███▄ ▄███▓    ██▓███   ▄▄▄       ▄████▄   ██ ▄█▀▄▄▄        ▄████ ▓█████   ██████
  # ▒██    ▒ ▒██  ██▒▒██    ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██▒▀█▀ ██▒   ▓██░  ██▒▒████▄    ▒██▀ ▀█   ██▄█▒▒████▄     ██▒ ▀█▒▓█   ▀ ▒██    ▒
  # ░ ▓██▄    ▒██ ██░░ ▓██▄   ▒ ▓██░ ▒░▒███   ▓██    ▓██░   ▓██░ ██▓▒▒██  ▀█▄  ▒▓█    ▄ ▓███▄░▒██  ▀█▄  ▒██░▄▄▄░▒███   ░ ▓██▄
  #   ▒   ██▒ ░ ▐██▓░  ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██    ▒██    ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄░██▄▄▄▄██ ░▓█  ██▓▒▓█  ▄   ▒   ██▒
  # ▒██████▒▒ ░ ██▒▓░▒██████▒▒  ▒██▒ ░ ░▒████▒▒██▒   ░██▒   ▒██▒ ░  ░ ▓█   ▓██▒▒ ▓███▀ ░▒██▒ █▄▓█   ▓██▒░▒▓███▀▒░▒████▒▒██████▒▒
  # ▒ ▒▓▒ ▒ ░  ██▒▒▒ ▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░░ ▒░   ░  ░   ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒▒▒   ▓▒█░ ░▒   ▒ ░░ ▒░ ░▒ ▒▓▒ ▒ ░
  # ░ ░▒  ░ ░▓██ ░▒░ ░ ░▒  ░ ░    ░     ░ ░  ░░  ░      ░   ░▒ ░       ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░ ▒   ▒▒ ░  ░   ░  ░ ░  ░░ ░▒  ░ ░
  # ░  ░  ░  ▒ ▒ ░░  ░  ░  ░    ░         ░   ░      ░      ░░         ░   ▒   ░        ░ ░░ ░  ░   ▒   ░ ░   ░    ░   ░  ░  ░
  #       ░  ░ ░           ░              ░  ░       ░                     ░  ░░ ░      ░  ░        ░  ░      ░    ░  ░      ░
  #          ░ ░                                                               ░

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    gnupg
    neofetch
    btop

    unstable.spotify

    unstable.easyeffects

    # unstable.wineWowPackages.waylandFull
    unstable.wineWowPackages.staging

    xorg.xhost

    nixpkgs-fmt
    nvd
    gtk3
    gobject-introspection

    (python3.withPackages (ps: with ps; [ pandas requests dbus-python pygobject3 ]))

    (runCommand "python-with-gtk"
      {
        buildInputs = [ gtk3 ];
        nativeBuildInputs = [ gobject-introspection wrapGAppsHook ];
      } ''
      mkdir -p $out/bin
      cp ${python3.withPackages (p: [p.pygobject3 p.dbus-python])}/bin/python $out/bin/python-with-gtk
      wrapGAppsHook
    '')

  ];

  programs.dconf.enable = true;

  nix.settings.auto-optimise-store = true;




  #   ██████ ▓█████  ██▀███   ██▒   █▓ ██▓ ▄████▄  ▓█████   ██████
  # ▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒▓██░   █▒▓██▒▒██▀ ▀█  ▓█   ▀ ▒██    ▒
  # ░ ▓██▄   ▒███   ▓██ ░▄█ ▒ ▓██  █▒░▒██▒▒▓█    ▄ ▒███   ░ ▓██▄
  #   ▒   ██▒▒▓█  ▄ ▒██▀▀█▄    ▒██ █░░░██░▒▓▓▄ ▄██▒▒▓█  ▄   ▒   ██▒
  # ▒██████▒▒░▒████▒░██▓ ▒██▒   ▒▀█░  ░██░▒ ▓███▀ ░░▒████▒▒██████▒▒
  # ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▐░  ░▓  ░ ░▒ ▒  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░
  # ░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░   ░ ░░   ▒ ░  ░  ▒    ░ ░  ░░ ░▒  ░ ░
  # ░  ░  ░     ░     ░░   ░      ░░   ▒ ░░           ░   ░  ░  ░
  #       ░     ░  ░   ░           ░   ░  ░ ░         ░  ░      ░
  #                               ░       ░

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.kodi.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];


  services.flatpak.enable = true;

  services.upower.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  #   ▒█████   ██▒   █▓▓█████  ██▀███   ██▓    ▄▄▄     ▓██   ██▓  ██████
  # ▒██▒  ██▒▓██░   █▒▓█   ▀ ▓██ ▒ ██▒▓██▒   ▒████▄    ▒██  ██▒▒██    ▒
  # ▒██░  ██▒ ▓██  █▒░▒███   ▓██ ░▄█ ▒▒██░   ▒██  ▀█▄   ▒██ ██░░ ▓██▄
  # ▒██   ██░  ▒██ █░░▒▓█  ▄ ▒██▀▀█▄  ▒██░   ░██▄▄▄▄██  ░ ▐██▓░  ▒   ██▒
  # ░ ████▓▒░   ▒▀█░  ░▒████▒░██▓ ▒██▒░██████▒▓█   ▓██▒ ░ ██▒▓░▒██████▒▒
  # ░ ▒░▒░▒░    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒░▓  ░▒▒   ▓▒█░  ██▒▒▒ ▒ ▒▓▒ ▒ ░
  #   ░ ▒ ▒░    ░ ░░   ░ ░  ░  ░▒ ░ ▒░░ ░ ▒  ░ ▒   ▒▒ ░▓██ ░▒░ ░ ░▒  ░ ░
  # ░ ░ ░ ▒       ░░     ░     ░░   ░   ░ ░    ░   ▒   ▒ ▒ ░░  ░  ░  ░
  #     ░ ░        ░     ░  ░   ░         ░  ░     ░  ░░ ░           ░
  #               ░                                    ░ ░

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-11.5.0"
        "electron-13.6.9"
      ];

    };
  };

  documentation.nixos.enable = false;



  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  security.sudo.extraConfig = ''Defaults lecture = never'';

  users.users.root = {
    hashedPassword = "$6$3MUfKpf9tTbjwOmi$W5YLaW3rOb.B2pnbFHAumdgRl1IcA4qept0S9yTsADEqitSqjZYB9vXJ4TSKhO6CSII8xLsnIcc73BvF3szhF1";
  };

  users.users.ammy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$3MUfKpf9tTbjwOmi$W5YLaW3rOb.B2pnbFHAumdgRl1IcA4qept0S9yTsADEqitSqjZYB9vXJ4TSKhO6CSII8xLsnIcc73BvF3szhF1";
  };

  system.activationScripts.report-changes = ''
    PATH=$PATH:${lib.makeBinPath [ pkgs.nvd pkgs.nix ]}
    nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)
  '';


  #  ██▒   █▓▓█████  ██▀███    ██████  ██▓ ▒█████   ███▄    █
  # ▓██░   █▒▓█   ▀ ▓██ ▒ ██▒▒██    ▒ ▓██▒▒██▒  ██▒ ██ ▀█   █
  #  ▓██  █▒░▒███   ▓██ ░▄█ ▒░ ▓██▄   ▒██▒▒██░  ██▒▓██  ▀█ ██▒
  #   ▒██ █░░▒▓█  ▄ ▒██▀▀█▄    ▒   ██▒░██░▒██   ██░▓██▒  ▐▌██▒
  #    ▒▀█░  ░▒████▒░██▓ ▒██▒▒██████▒▒░██░░ ████▓▒░▒██░   ▓██░
  #    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒
  #    ░ ░░   ░ ░  ░  ░▒ ░ ▒░░ ░▒  ░ ░ ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░
  #      ░░     ░     ░░   ░ ░  ░  ░   ▒ ░░ ░ ░ ▒     ░   ░ ░
  #       ░     ░  ░   ░           ░   ░      ░ ░           ░
  #      ░

  system.stateVersion = "23.05"; # Did you read the comment?
}
