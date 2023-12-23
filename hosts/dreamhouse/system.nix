{ inputs
, outputs
, config
, pkgs
, lib
, jovian-nixos
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/grub
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

  hardware.opentabletdriver.enable = true;
  hardware.steam-hardware.enable = true;

  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      # enable this module
      enable = false;
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 27036 ];
    allowedUDPPortRanges = [
      { from = 27031; to = 27036; }
      { from = 8000; to = 8010; }
    ];
  };


  # make pipewire realtime-capable
  security.rtkit.enable = true;

  services.openssh.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];


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
    wget
    git
    gnupg
    neofetch
    btop

    spotify

    easyeffects

    wineWowPackages.staging

    nixpkgs-fmt
    nvd
    file
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];

  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];


  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
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
  #services.xserver.desktopManager.kodi.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

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
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-11.5.0"
        "electron-13.6.9"
        "electron-24.8.6"
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
    PATH=$PATH:${lib.makeBinPath [pkgs.nvd pkgs.nix]}
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
