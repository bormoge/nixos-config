{
  description = "NixOS flake";

  inputs = {
    # nixos-25.11 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-flatpak, ... }: {
    # nixos is the hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules =
        [
          ./configuration.nix
          {
            nix = {
              settings.experimental-features = [ "nix-command" "flakes" ];
            };
          }
          ./git.nix
          ./emacs.nix
          ./virtualization.nix
          nix-flatpak.nixosModules.nix-flatpak
          ./flatpak.nix
          ./update-flake-lock.nix
        ];
    };
  };
}

### Quick guide / cheatsheet for myself
# nix flake update                                          # Update flake lock
# nix flake check                                           # Check that flake works
# sudo nixos-rebuild switch --flake .                       # Update NixOS using flakes
# nixos-rebuild list-generations                            # List NixOS generations
# (sudo) nix-collect-garbage                                # Activate the garbage collection
# nix-collect-garbage --delete-older-than                   # Remove older generations
# nix-collect-garbage -d                                    # Remove all but one generation
# sudo nixos-rebuild boot                                   # Update displayed generations on boot
# nix store optimise                                        # Optimize disk space usage
# nixos-version                                             # Check NixOS version

## Check autoupgrade service(s)
# systemctl list-timers --all

# systemctl status nixos-upgrade.timer
# systemctl status nixos-upgrade.service
# journalctl -u nixos-upgrade.service
# journalctl -u nixos-upgrade.service > nixos-upgrade.txt

# systemctl status nix-gc.service
# systemctl status nix-gc.timer
# journalctl -u nix-gc.service
# journalctl -u nix-gc.service > nix-gc.txt
