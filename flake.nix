{
  description = "NixOS flake";

  inputs = {
    # nixos-25.05 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # nixos is the hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          programs.git = {
            enable = true;
            lfs.enable = true;
          };
        }
        {
          services.flatpak.enable = true;
        }
	{
          config.services.postgresql = {
	    enable = true;
	  };
        }
	{
	  services.fwupd.enable = true;
	}
      ];
    };
  };
}
