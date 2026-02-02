{ pkgs, ... }:

let
  user = "gbm";
  flakePath = "/home/${user}/nixos/";
in
{
  ## Update flake inputs daily
  systemd.services = {
    update-flake-lock = {
      unitConfig = {
        Description = "Update flake.lock";
        StartLimitIntervalSec = 300;
        StartLimitBurst = 5;
      };
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix flake update --flake ${flakePath}";
        Restart = "on-failure";
        RestartSec = "30";
        Type = "oneshot";
        User = "${user}";
      };
      before = [ "nixos-upgrade.service" ];
      wantedBy = [ "nixos-upgrade.service" ];
      path = [
        pkgs.nix
        pkgs.git
        pkgs.host
      ];
    };
  };
}
