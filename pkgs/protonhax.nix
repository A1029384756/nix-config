{ lib, stdenv, fetchzip, gnumake, tinycc }:
let
version = "1.0.4";
src = fetchzip {
  url =
    "https://github.com/jcnils/protonhax/archive/refs/tags/1.0.4.zip";
  sha256 = "sha256-3s1pmHcQy/xJS6ke0Td3tkXAhXcTuJ4mb3Dtpxb2/6o=";
};
in stdenv.mkDerivation {
  pname = "protonhax";
  inherit version;

  inherit src;

  nativeBuildInputs = [ gnumake tinycc ];

  installPhase = ''
    runHook preInstall

    make
    chmod 755 ./protonhax
    chmod 755 ./envload

    mkdir -p $out/bin
    cp -a protonhax $out/bin
    cp -a envload $out/bin

    runHook postInstall
    '';

  meta = with lib; {
    description = "Protonhax 1.0.4";
    homepage = "https://github.com/jcnils/protonhax";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ haydengray ];
  };
}
