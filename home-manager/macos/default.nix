{ pkgs, ... }:
{
	imports = [
		../shell.nix
		../nvim.nix
		../kitty.nix
		../wezterm.nix
		../git.nix
	];

	config = {
		isWork = true;
		fonts.fontconfig.enable = true;
		home.stateVersion = "26.05";
		programs.home-manager.enable = true;
		programs.man = {
			package = pkgs.man;
			enable = true;
			generateCaches = true;
		};
		programs.fish = {
			interactiveShellInit = ''
				if set -q REX_BIN_DIR
					fish_add_path --path --prepend --move $REX_BIN_DIR
				end
			'';
		};
	};
}
