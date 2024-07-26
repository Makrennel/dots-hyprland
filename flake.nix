{
	description = "Illogical Impulse Config Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		ags.url = "github:Aylur/ags/05e0f23534fa30c1db2a142664ee8f71e38db260";
		systems.url = "github:nix-systems/default-linux";
	};

	outputs = { self, ags, nixpkgs, systems }: let
		inherit (nixpkgs) lib;
		eachSystem = nixpkgs.lib.genAttrs (import systems);
		pkgs = eachSystem (system: nixpkgs.legacyPackages.${system});
	in {
		packages = eachSystem (system: {
			default = (import ./nix/default.nix { inherit self; pkgs = pkgs.${system}; });
			gabarito = (import ./nix/gabarito.nix { pkgs = pkgs.${system}; });
			rubik = (import ./nix/rubik.nix { pkgs = pkgs.${system}; });
#			microtex = (import ./nix/microtex.nix { pkgs = pkgs.${system}; });
			readex-pro = (import ./nix/readex-pro.nix { pkgs = pkgs.${system}; });
			oneui4-icons = (import ./nix/oneui4-icons.nix { pkgs = pkgs.${system}; });
		});

		homeManagerModules.default = import ./nix/hm-module.nix self;
	};
}
