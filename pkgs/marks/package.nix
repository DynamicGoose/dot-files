{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation {
  pname = "marks";
  version = "1.0";

  src = fetchzip {
    url = "https://meinbdp.de/download/attachments/432144490/MARKS.zip";
    sha256 = "sha256-B+nT2y0lTxOnJVnduqIDas+7Kg/iT6Ms+bVAVZo5jo0=";
    stripRoot = false;
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/opentype/ *.otf
    runHook postInstall
  '';

  meta = with lib; {
    description = "Accent CD font of the BdP";
    homepage = "https://meinbdp.de/spaces/BUND/pages/432144490/Einfach+umsetzen.+Das+BdP+Corporate+Design";
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
