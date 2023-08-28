{ inputs, outputs, config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/grub
    ../../modules/nixos/nvidia
    ../../modules/nixos/persistence
    ../../modules/nixos/fonts
    ../../modules/nixos/networking
    ../../modules/nixos/nix
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

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opentabletdriver.enable = true;
  hardware.steam-hardware.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

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
    gnome.gnome-software
    gnome.gnome-terminal
    neofetch
    btop

    spotify

    easyeffects

    wineWowPackages.waylandFull

    xorg.xhost

    steamtinkerlaunch
    unzip
    xdotool
    xorg.xwininfo
    unixtools.xxd
    protonup-qt

    nixpkgs-fmt
    nvd
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;
  programs.dconf.enable = true;

  nix.settings.auto-optimise-store = true;

  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };




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
  services.xserver.desktopManager.gnome.enable = false;
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.desktopManager.kodi.enable = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.flatpak.enable = true;
  services.xserver.enable = true;

  services.upower.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

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
      ];
    };
  };


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

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
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
