# mostly taken from https://github.com/ardishko/fluxer-nix
{
  fluxer-src ? fetchFromGitHub {
    owner = "fluxerapp";
    repo = "fluxer";
    rev = "03813bbe17db008452f0f1be3090a7d2970a5447";
    hash = "sha256-B8V1O1JhoK13yJS29LhTlwltdfh7f2XyzrKjZVdLQVY=";
  },
  stdenv,
  fetchFromGitHub,
  autoPatchelfHook,
  makeWrapper,
  glib,
  nspr,
  nss,
  dbus,
  at-spi2-atk,
  cups,
  cairo,
  gtk3,
  pango,
  libX11,
  libXcomposite,
  libXdamage,
  libXext,
  libXtst,
  libXt,
  libXfixes,
  libXrandr,
  libgbm,
  expat,
  libxcb,
  libxkbcommon,
  eudev,
  alsa-lib,
  lib,
  libGL,
  writeText,
  electron_40,
  fetchPnpmDeps,
  pnpmConfigHook,
  pnpm,
  nodejs,
  python3,
  esbuild,
  ...
}:
stdenv.mkDerivation rec {
  pname = "fluxer";
  version = "1.0.0-canary";

  src = "${fluxer-src}/fluxer_desktop";
  patches = [ ./refactor.patch ];

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    pnpmConfigHook
    pnpm
    nodejs
    python3
    esbuild
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src;
    fetcherVersion = 3;
    hash = "sha256-Rh84JplYrd9k4fslofQli4fRNKmFhosftUfYXKBKU4g=";
  };

  pnpmInstallFlags = [
    "--frozen-lockfile"
  ];

  buildInputs = [
    glib
    nspr
    nss
    dbus.lib
    at-spi2-atk
    cups.lib
    cairo
    gtk3
    pango
    libX11
    libXcomposite
    libXdamage
    libXext
    libXtst
    libXt
    libXfixes
    libXrandr
    libgbm
    expat
    libxcb
    libxkbcommon
    eudev
    alsa-lib
  ];

  installPhase = ''
    pnpm run set-channel stable
    pnpm build

    pnpm exec electron-builder --config electron-builder.config.cjs --linux \
    --dir \
    -c.electronDist=${electron_40}/libexec/electron \
    -c.electronVersion=${electron_40.version} \
    -c.npmRebuild=false \

    mkdir -p $out/share/fluxer
    mkdir -p $out/bin

    cp -r ./dist-electron/linux-unpacked/resources/* $out/share/fluxer

    ls -la ./dist-electron/linux-unpacked/fluxer_desktop
    ls -la ./dist-electron/linux-unpacked/resources

    makeWrapper ${electron_40}/bin/electron $out/bin/fluxer \
    --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libGL ]}" \
    --add-flags "$out/share/fluxer/app.asar"

    mkdir -p $out/share/applications/
    substitute ${writeText "fluxer_desktop.desktop" ''
      [Desktop Entry]
      Name=Fluxer
      Comment=OSS messaging platform
      Exec=@out@/bin/fluxer
      Icon=fluxer_desktop
      Terminal=false
      Type=Application
      StartupNotify=true
      StartupWMClass=fluxer_desktop
    ''} $out/share/applications/fluxer_desktop.desktop --subst-var out

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ./packaging/linux/app.fluxer.Fluxer.svg $out/share/icons/hicolor/scalable/apps/fluxer_desktop.svg
  '';
}
