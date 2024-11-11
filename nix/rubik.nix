{ pkgs }: pkgs.stdenv.mkDerivation {
  pname = "rubik";
  version = "2.300";

  src = pkgs.fetchFromGitHub {
    owner = "googlefonts";
    repo = "rubik";
    rev = "9167c98fa8699d75ee51769eba20d81beb16bcb5";
    sha256 = "sha256-iyjEiGlfvCr/sMJNsl1ycuMfmicDeE0dh4GUsST/w78=";
  };

  installPhase = ''
    mkdir -p $out/share/licenses/rubik $out/share/fonts/{opentype,truetype,woff2}
    install -Dm644 fonts/otf/*.otf $out/share/fonts/opentype
    install -Dm644 fonts/ttf/*.ttf $out/share/fonts/truetype
    install -Dm644 fonts/variable/*.ttf $out/share/fonts/truetype
    install -Dm644 fonts/webfonts/*.woff2 $out/share/fonts/woff2
    install -Dm644 OFL.txt $out/share/licenses/rubik
  '';
}

