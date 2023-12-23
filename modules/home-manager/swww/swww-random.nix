{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.swww-random;
  shell = ''find "/home/ammy/.config/home-manager/files/wallpapers" -type f | shuf -n 1'';

in
{
  options.services.swww-random = {
    enable = mkEnableOption "swww-random";
  };

  config = mkIf cfg.enable {

    systemd.user.timers."swww-random-timer" = {
      Unit = {
        Description = "Wayland wallpaper";
      };

      Timer = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "swww-random.service";

      };

      Install.WantedBy = [ "timers.target" ];
    };

    systemd.user.services = {
      swww-random = {
        Unit = {
          Description = "Wayland wallpaper";
        };

        Service = {
          ExecStart = ''
            ${pkgs.bash}/bin/bash -c '${pkgs.swww}/bin/swww img "$(${pkgs.findutils}/bin/find "/home/ammy/.config/home-manager/files/wallpapers" -type f | ${pkgs.coreutils}/bin/shuf -n 1)"'
          '';
          Restart = "always";
        };
      };
    };
  };
}


