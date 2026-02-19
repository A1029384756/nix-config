{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.8.1";

		src = pkgs.fetchFromGitHub {
			owner = "hazre";
			repo = "cinny";
			rev = "c97fba71fa7d5c3e91037184e1fcd7955a4b7fac";
			hash = "sha256-mduhDeBlMZenQZDUwkjI3LGG0bk97pdBNfFVR2Nnzz0=";
		};

		npmDepsHash = "sha256-LFmZFhZ0+/g4bwIeu0Zi5i3Bn4H50DZfc2oP8g3e+6Y=";

		nodejs = pkgs.nodejs_20;

		nativeBuildInputs = with pkgs; [
			pkg-config
			python3
		];

		buildInputs = with pkgs; [
			cairo
			pango
			libjpeg
			giflib
			librsvg
			pixman
		];

		npmBuildScript = "build";

		installPhase = ''
			runHook preInstall
			mkdir -p $out
			cp -r dist/* $out/
			runHook postInstall
		'';
	};
in
{
	services.caddy.virtualHosts."cinny.cstring.dev".extraConfig = ''
		root * ${cinny}
		file_server
		try_files {path} /index.html
	'';
}
