{ pkgs }: pkgs.stdenv.mkDerivation {
	pname = "gabarito";
	version = "1.000.r78";

	src = pkgs.fetchFromGitHub {
		owner = "naipefoundry";
		repo = "gabarito";
		rev = "1f3fb39d6449eefa880543f109f33ede0cd4064f";
		sha256 = "sha256-cZMANs/csO4EZJ6iykRbY20wPib9L+S9oj233oNYfF0=";
	};

	installPhase = ''
		mkdir -p $out/share/licenses/gabarito $out/share/fonts/{truetype,woff2}
		install -Dm644 fonts/ttf/*.ttf $out/share/fonts/truetype
		install -Dm644 fonts/variable/*.ttf $out/share/fonts/truetype
		install -Dm644 fonts/webfonts/*.woff2 $out/share/fonts/woff2
		install -Dm644 OFL.txt $out/share/licenses/gabarito
	'';
}

