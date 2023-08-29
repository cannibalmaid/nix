{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.swww-random
  ;
in
{
  options.services.swww-random = {
    enable = mkEnableOption "swww-random";
  };

  config = mkIf cfg.enable {

    systemd.user.timers."swww-random-timer" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "swww-random.service";
      };
    };


    systemd.user.services = {
      swww-random = {
        Unit = {
          Description = "Wayland wallpaper";
        };

        Install.WantedBy = [ "hyprland-session.target" ];

        Service = {
          ExecStart = ''${pkgs.swww}/bin/swww img $(find "./files/wallpapers" - type f | shuf - n 1)'';
          Restart = "always";
        };
      };
    };
  };
}
