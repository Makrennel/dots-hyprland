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

		configFiles = builtins.listToAttrs (builtins.map (name: lib.nameValuePair name {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
				description = "Allows user to disable sourcing of config file ${name} so that a user-supplied version can be manually sourced instead";
			};
		}) configFiles);

		# Home Manager sources hyprland.conf from hyprland causing a conflict so we have to manually deal with it....
		generate-hyprland-conf = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "Allows the user to disable default creation of hypr/hyprland.conf file so that wayland.windowManager.hyprland.settings can be used directly without illogical-impulse's conf.";
		};

		configHome = lib.mkOption {
			type = lib.types.str;
			default = ".config";
			description = "The config directory relative to your home directory to source files to - usually should be the same as XDG_CONFIG_HOME.";
		};
	};

	config = lib.mkIf config.illogical-impulse.enable {
 		home.file = (lib.lists.foldl (a: b: a // b) { } (
			map (path: if config.illogical-impulse.configFiles."${path}".enable
				then { "${config.illogical-impulse.configHome}/${path}".source = "${../.config}/${path}"; }
				else { "${config.illogical-impulse.configHome}/${path}" = {}; }
			) configFiles)
		);

		wayland.windowManager.hyprland.enable = true;
		wayland.windowManager.hyprland.settings = lib.mkIf config.illogical-impulse.generate-hyprland-conf {
			"source" = [
				"hyprland/env.conf"
				"hyprland/exec.conf"
				"hyprland/general.conf"
				"hyprland/rules.conf"
				"hyprland/colors.conf"
				"hyprland/keybinds.conf"

				"custom/env.conf"
				"custom/exec.conf"
				"custom/general.conf"
				"custom/rules.conf"
				"custom/keybinds.conf"
			];
		};

		programs.ags.enable = true;
		programs.ags.extraPackages = with pkgs; [
			accountsservice
			gtksourceview
			gnome.gvfs
			webkitgtk
		];

		home.packages = [
			self.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};

}

