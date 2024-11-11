self: { config, inputs, lib, pkgs, ...}: let
  configFiles-store = pkgs.runCommand "get-config-files" {} "find ${../.config} -type f | sed 's/^.*.config\\///' | grep -v hypr/custom | grep -v hypr/hyprland.conf > $out";
  configFilesStr = builtins.readFile configFiles-store;
  configFilesPre = lib.strings.split "\n" configFilesStr;
  configFiles = lib.lists.filter (e: ! (e == "" || e == [])) configFilesPre;
in {
  imports = [
    self.inputs.ags.homeManagerModules.default
  ];

  options.illogical-impulse = {
    enable = lib.mkEnableOption "illogical-impulse";
  };

  config = lib.mkIf config.illogical-impulse.enable {
    xdg.configFile = (lib.lists.foldl (a: b: a // b) { } (
      lib.lists.forEach configFiles (path: ${path} = {
        enable = lib.mkDefault true;
        source = lib.mkDefault "${../.config}/${path}";
      };)
    ));
    
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings."source" = lib.mkDefault [
      "${config.xdg.configHome}/hypr/hyprland/env.conf"
      "${config.xdg.configHome}/hypr/hyprland/execs.conf"
      "${config.xdg.configHome}/hypr/hyprland/general.conf"
      "${config.xdg.configHome}/hypr/hyprland/rules.conf"
      "${config.xdg.configHome}/hypr/hyprland/colors.conf"
      "${config.xdg.configHome}/hypr/hyprland/keybinds.conf"

      "${config.xdg.configHome}/hypr/custom/env.conf"
      "${config.xdg.configHome}/hypr/custom/execs.conf"
      "${config.xdg.configHome}/hypr/custom/general.conf"
      "${config.xdg.configHome}/hypr/custom/rules.conf"
      "${config.xdg.configHome}/hypr/custom/keybinds.conf"
    ];

    programs.ags.enable = true;
    programs.ags.extraPackages = with pkgs; [
      accountsservice
      gtksourceview
      gnome.gvfs
      webkitgtk
    ];

    home.packages = with pkgs; [
      # Audio
      libdbusmenu-gtk3
      pavucontrol
      plasma-browser-integration
      playerctl
      swww
      wireplumber

      # Screen
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

      #self.packages.${pkgs.stdenv.hostPlatform.system}.microtex

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
  };

}

