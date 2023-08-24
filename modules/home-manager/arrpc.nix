{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.services.arrpc;
in {
  options.services.arrpc = {
    enable = mkEnableOption "arrpc";
  };
  
  config = mkIf cfg.enable {
    systemd.user.services = {
      arrpc = {
        Unit = {
          Description = "Open-source Discord RPC";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };

        Install.WantedBy = ["graphical-session.target"];

        Service = {
          ExecStart = ''${pkgs.arrpc}/bin/arRPC'';
          Restart = "always";
        };
      };
    };
  };
}