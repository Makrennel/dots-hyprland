{ pkgs }: let
	# This is so old that it doesn't have a flake.nix to be used as a flake input
	gsvpkgs = import (builtins.fetchGit {
		name = "old-gtksourceviewmm";
		url = "https://github.com/NixOS/nixpkgs";
		ref = "refs/heads/nixos-unstable";
		rev = "e8d3c74b499ad026e40ca77f54214444f9461e3c";
	}) {};
in pkgs.stdenv.mkDerivation {
	pname = "microtex";
	version = "r492.d87ebec";

	src = pkgs.fetchFromGitHub {
		owner = "NanoMichael";
		repo = "MicroTeX";
		rev = "d87ebec8436ae01a1eb183d985c1375e39b2a542";
		sha256 = "sha256-L4bx8x9hobwQQCt8Rsd1ycr0FZfHBbKBJfL3LpZu2HM=";
	};

	nativeBuildInputs = with pkgs; [
		cmake
		pkgconf
		cairomm
		gtkmm3
		gsvpkgs.gtksourceviewmm
		tinyxml-2
	];
	
	bulldInputs = with pkgs; [
		cairomm
		gtkmm3
		gsvpkgs.gtksourceviewmm
		tinyxml-2
	];

	buildPhase = ''
		cmake -B build -S . -DCMAKE_BUILD_TYPE=None
		cmake --build build
	'';

	installPhase = ''
		mkdir -p $out/bin $out/share/microtex
		install -Dm0755 -t $out/share/microtex build/LaTeX
		cp -r build/res $out/share/microtex
		install -Dm0644 -t $out/share/licenses/microtex LICENSE
		ln -s ../share/microtex/LaTeX $out/bin
	'';
}
