{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.8.1";

		src = pkgs.fetchFromGitHub {
			owner = "hazre";
			repo = "cinny";
			rev = "1f2f8ffa499a1881bc9c4aee90d76a27a0ade032";
			hash = "sha256-Uilek7gbE1mfGb5gOtrYAp8SJabBlPI0/7o1rI0kOL4=";
		};

		npmDepsHash = "sha256-Pn6P5TJTpIGL4xVPhuNsP7/P3BsbCQTP+BKiqILGJdk=";

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
