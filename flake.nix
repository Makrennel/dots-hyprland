{
	description = "Illogical Impulse Config Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		ags.url = "github:Aylur/ags/05e0f23534fa30c1db2a142664ee8f71e38db260";

	};

	outputs = { self, ags, nixpkgs }: {
		homeManagerModules.default = import ./nix/hm-module.nix self;
	};
}
