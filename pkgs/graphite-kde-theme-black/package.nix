{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
  gitUpdater,
}:

stdenv.mkDerivation rec {
  pname = "graphite-kde-theme-black";
  version = "unstable-2025-02-18";

  src = fetchFromGitHub {
    owner = "dynamicgoose";
    repo = pname;
    rev = "90d0ffcd98133341247c9544433283f14fd37fb8";
    hash = "sha256-UPItuVgNl6uYiK1OeoY9O32ZtfwxUen2BpG7cjMTNVE=";
  };

  # Propagate sddm theme dependencies to user env otherwise sddm does
  # not find them. Putting them in buildInputs is not enough.
  propagatedUserEnvPkgs = [
    pkgs.libsForQt5.kdeclarative.bin
    pkgs.libsForQt5.plasma-framework
    pkgs.libsForQt5.plasma-workspace
  ];

  postPatch = ''
    patchShebangs install.sh

    substituteInPlace install.sh \
      --replace '$HOME/.local' $out \
      --replace '$HOME/.config' $out/share

    substituteInPlace sddm/*/Main.qml \
      --replace /usr $out
  '';

  installPhase = ''
    runHook preInstall

    name= ./install.sh

    mkdir -p $out/share/sddm/themes
    cp -a sddm/Graphite* $out/share/sddm/themes/

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "Flat Design theme for KDE Plasma desktop";
    homepage = "https://github.com/DynamicGoose/Graphite-kde-theme-black";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
