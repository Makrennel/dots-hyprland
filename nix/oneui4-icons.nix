{ pkgs }: pkgs.stdenv.mkDerivation {
	name = "oneui4-icons";
	version = "r64.9ba2190";

	src = pkgs.fetchFromGitHub {
		owner = "end-4";
		repo = "OneUI4-Icons";
		rev = "9ba21908f6e4a8f7c90fbbeb7c85f4975a4d4eb6";
		sha256 = "sha256-f5t7VGPmD+CjZyWmhTtuhQjV87hCkKSCBksJzFa1x1Y=";
	};

	installPhase = ''
		mkdir -p $out/share/icons
		for _i in OneUI{,-dark,-light}; do
			cp -dr --no-preserve=mode "$_i" "$out/share/icons/$_i"
		done
	'';
}
