{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.8.1";

		src = pkgs.fetchFromGitHub {
			owner = "hazre";
			repo = "cinny";
			rev = "4f498af4583e2b072c1634abb4a9173c4b2d38ec";
			hash = "sha256-rrYHr3npd7GUx+Zs0n8XxRee8TFHSOwTjnLyvpqUcwo=";
		};

		npmDepsHash = "sha256-z/WDfFriE887eULQU8WktNkx4jJBmqcGvQueNw2A6aA=";

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
