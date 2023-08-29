{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.arrpc;
in
{
  options.services.arrpc = {
    enable = mkEnableOption "swww";
  };

  config = mkIf cfg.enable {
    systemd.user.services = {
      arrpc = {
        Unit = {
          Description = "Wayland wallpaper";
        };

        Install.WantedBy = [ "hyprland-session.target" ];

        Service = {
          ExecStart = ''${pkgs.swww}/bin/swww init'';
          Restart = "always";
        };
      };
    };
  };
}
