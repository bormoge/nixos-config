{
  description = "NixOS flake";

  inputs = {
    # nixos-25.11 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
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

      ];
    };
  };
}
