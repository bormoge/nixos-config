{ pkgs, ... }:

let
  user = "gbm";
  flakePath = "/home/${user}/nixos/";
in
  {
    # Here lies my experimental config to update NixOS.
    # Theoretically it should work if your nixos-config directory is owned by root, but I haven't tested that.
    # If you use this code, check the logs with this command: journalctl -u rebuild-nixos-system.service
    systemd.services = {
      rebuild-nixos-system = {
        unitConfig = {
          Description = "Rebuild NixOS system.";
          StartLimitIntervalSec = 300;
          StartLimitBurst = 5;
        };
        serviceConfig = {
          ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ${flakePath}";
          Restart = "on-failure";
          RestartSec = "30";
          Type = "oneshot";
          # User = "${user}";
        };
        # after = [ "update-flake-lock.service" ];
        path = [
          pkgs.nix
          pkgs.nixos-rebuild
          pkgs.git
          pkgs.host
        ];
      };
    };
    systemd.timers = {
      rebuild-nixos-system = {
        description = "Run rebuild-nixos-system.service weekly, each Sunday at 16:15.";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnStartupSec = "15min";
          OnCalendar = "Sun 16:15";
          Unit = "rebuild-nixos-system.service";
          Persistent = true;
          # RandomizedDelaySec = "30m";
          # allowReboot = true;
          # rebootWindow = {
          #   lower = "16:00";
          #   upper = "19:00";
          # };
        };
      };
    };
  }
