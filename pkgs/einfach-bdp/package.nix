{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation {
  pname = "einfach-bdp";
  version = "1.0";

  src = fetchzip {
    url = "https://meinbdp.de/download/attachments/432144490/einfachBdP.zip";
    sha256 = "sha256-Y2RGoMNtYL+B2puc6eImZfZUiwZp3oGRPLzGXm4LFW4=";
    stripRoot = false;
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/opentype/ einfachBdP/*.otf
    runHook postInstall
  '';

  meta = with lib; {
    description = "Regular CD font of the BdP";
    homepage = "https://meinbdp.de/spaces/BUND/pages/432144490/Einfach+umsetzen.+Das+BdP+Corporate+Design";
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
