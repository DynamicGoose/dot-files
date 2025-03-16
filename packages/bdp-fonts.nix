{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "bdp-fonts";
  version = "1.0";

  src = fetchzip {
    url = "https://meinbdp.de/download/attachments/60719504/BdP_CorporateDesign_Schriftarten_V1.zip";
    sha256 = "sha256";
    stripRoot = false;
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/truetype/ BdPCorporateFonts/*.ttf
    runHook postInstall
  '';

  meta = with lib; {
    description = "Corporate fonts of the BdP";
    homepage = "https://meinbdp.de/spaces/OeArbeit/pages/60719504/Schriften+und+Farbe";
    license = licenses.ofl;
    maintainers = [];
    platforms = platforms.all;
  };
}
