{
  lib,
  stdenv,
  fetchzip,
  unzip,
}:
let
  version = "0.13.3";
  src = fetchzip {
    url = "https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip";
    sha256 = "sha256-yzLXwAcEnkJLtvcUJJVJsNPTObE6ziGB5RITQcG398Q=";
  };

in
stdenv.mkDerivation {
  pname = "terraform";
  inherit version;

  inherit src;

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin;
    cp -a terraform $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Terraform version 0.13.3";
    homepage = "https://github.com/catppuccin/gtk";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ haydengray ];
  };
}
