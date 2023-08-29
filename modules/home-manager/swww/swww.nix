{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.swww;
in
{
  options.services.swww = {
    enable = mkEnableOption "swww";
  };

  config = mkIf cfg.enable {
    systemd.user.services = {
      swww = {
        Unit = {
          Description = "Wayland wallpaper";
        };

        Install.WantedBy = [ "hyprland-session.target" ];

        Service = {
          ExecStart = ''${pkgs.swww}/bin/swww-daemon'';
          Restart = "always";
        };
      };
    };
  };
}
