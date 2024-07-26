{ pkgs }: pkgs.stdenv.mkDerivation {
	pname = "readex-pro";
	version = "1.r126";

	src = pkgs.fetchFromGitHub {
		owner = "ThomasJockin";
		repo = "readexpro";
		rev = "6a4f24e40e424ec77badb04c101af81da96ed157";
		sha256 = "sha256-GZ5NeHIE7b/LsoPzYuu34PxUfiZYR3yEY+1AdyzqOhw=";
	};

	installPhase = ''
		mkdir -p $out/share/licenses/readex-pro $out/share/fonts/truetype
		install -Dm644 fonts/ttf/*.ttf $out/share/fonts/truetype
		install -Dm644 fonts/variable/*.ttf $out/share/fonts/truetype
		install -Dm644 OFL.txt $out/share/licenses/readex-pro
	'';
}

