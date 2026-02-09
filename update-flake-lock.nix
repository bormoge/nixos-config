# { pkgs, ... }:

# let
#   user = "gbm";
#   flakePath = "/home/${user}/nixos/";
# in
#   {
#     ## I will comment the file bacause I have set some new flags on system.autoUpgrade and I want to check if it updates flake.lock. So this will stay commented for a week.
#     systemd.services = {
#       update-flake-lock = {
#         unitConfig = {
#           Description = "Update flake.lock";
#           StartLimitIntervalSec = 300;
#           StartLimitBurst = 5;
#         };
#         serviceConfig = {
#           ExecStart = "${pkgs.nix}/bin/nix flake update --flake ${flakePath}";
#           Restart = "on-failure";
#           RestartSec = "30";
#           Type = "oneshot";
#           User = "${user}";
#         };
#         before = [ "nixos-upgrade.service" ];
#         wantedBy = [ "nixos-upgrade.service" ];
#         path = [
#           pkgs.nix
#           pkgs.git
#           pkgs.host
#         ];
#       };
#     };
#   }
