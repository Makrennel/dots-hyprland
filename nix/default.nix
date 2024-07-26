{ self, pkgs }: let
	rel = if (self ? revCount) then self.revCount else "dirty";
	rev = if (self ? rev) then self.rev else "dirty";
in pkgs.stdenv.mkDerivation {
	pname = "illogical-impulse";
	version = "0.1.r${rel}.g${rev}";

	src = ../.;

	buildInputs = with pkgs; [
		# Audio
		libdbusmenu-gtk3
		pavucontrol
		plasma-browser-integration
		playerctl
		swww
		wireplumber

		brightnessctl
		ddcutil
		
		# GTK
		gobject-introspection
		gtk3
		gtksourceview3
		gtk-layer-shell
		upower
		wrapGAppsHook
		yad
		ydotool

		# Basic
		axel
		bc
		cliphist
		cmake
		coreutils
		curl
		fuzzel
		gojq
		jq
		meson
		nodejs_22
		ripgrep
		rsync
		typescript
		wget
		xdg-user-dirs

		# GNOME
		blueberry
		gammastep
		gnome.gnome-bluetooth
		gnome.gnome-control-center
		gnome.gnome-shell
		gnome-keyring
		nautilus
		networkmanager
		polkit_gnome

		# Python
		python312Packages.build
		python312Packages.libsass
		python312Packages.materialyoucolor
		python312Packages.material-color-utilities
		python312Packages.pillow
		python312Packages.psutil
		python312Packages.pywal
		python312Packages.pywayland
		python312Packages.setuptools-scm
		python312Packages.wheel

		# Screencapture
		grim
		slurp
		swappy
		tesseract
		wf-recorder

		# Theme
		adw-gtk3
		bibata-cursors
		fish
		foot
		gradience
		libsForQt5.qt5ct
		libsForQt5.qt5.qtwayland
		material-symbols
		starship
		self.packages.${pkgs.stdenv.hostPlatform.system}.oneui4-icons

		# Fonts
		self.packages.${pkgs.stdenv.hostPlatform.system}.gabarito
		self.packages.${pkgs.stdenv.hostPlatform.system}.readex-pro
		self.packages.${pkgs.stdenv.hostPlatform.system}.rubik
		(nerdfonts.override { fonts = [
			"JetBrainsMono"
			"SpaceMono"
		]; })

#		self.packages.${pkgs.stdenv.hostPlatform.system}.microtex

		# Widgets
		anyrun
		dart-sass
		hypridle
		hyprlock
		hyprpicker
		hyprutils
		wlogout
		wl-clipboard
	];
}

