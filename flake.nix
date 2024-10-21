{
description = "ukimNixOS Config";

inputs = {
	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	home-manager.url = "github:nix-community/home-manager/master";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

outputs = { self, nixpkgs, home-manager,  ... }@inputs: 
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
	nixosConfigurations = {
		workstation = lib.nixosSystem {
			inherit system;
			specialArgs = {inherit inputs;};
			modules = [
				./hosts/default/configuration.nix
				./modules/core/hyprland.nix
				./modules/core/rofi.nix
				./modules/core/audio.nix
			];
		};
	};
	homeConfigurations = {
		default =  home-manager.lib.homeManagerConfiguration { 
			inherit pkgs;
			modules = [
				./home-manager/default.nix
			];
		};
	};
};
}
