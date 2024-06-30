{
  description = "NixOS + standalone home-manager config flakes to get you started!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = {nixpkgs, ...}:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in {
      devShells = forAllSystems (system: {
      	default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = with nixpkgs.legacyPackages.${system}; [
          	python3
          	python3Packages.psutil
          	python3Packages.requests
          ];
          shellHook = "exec python3 ${./nixos-up.py}";
	};
      });
      templates = {
        minimal = {
          description = ''
            Minimal flake - minimum to migrate your existing legacy configs to flakes
          '';
          path = ./minimal;
        };
        standard = {
          description = ''
            Standard flake - boilerplate for custom packages, overlays, and reusable modules
          '';
          path = ./standard;
        };
      };
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
