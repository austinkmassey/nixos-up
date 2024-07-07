{
  description = "A test configuration and nixos sandbox";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#sandbox'
    nixosConfigurations = {
      sandbox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
	  home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
	    home-manager.users.sandboxer = import ./home-manager/home.nix;
	  }
	];
      };
    };
  };
}
