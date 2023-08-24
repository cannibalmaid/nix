{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.linux-discord-rich-presence;
in
{
  options.services.linux-discord-rich-presence = {
    enable = mkEnableOption "linux-discord-rich-presence";
  };

  config = mkIf cfg.enable {
    systemd.user.services = {
      linux-discord-rich-presence = {
        Unit = {
          Description = "Run Discord rich presence.";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };

        Install.WantedBy = [ "graphical-session.target" ];

        Service = {
          ExecStart = ''${pkgs.presence}/bin/linux-discord-rich-presence --config /home/mia/.config/home-manager/pkgs/linux-discord-rich-presence/config.sh'';
          Restart = "always";
        };
      };
    };
  };
}
