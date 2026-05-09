# { pkgs, ... }:
{
  flavor = "lineageos";
  device = "enchilada";

  microg.enable = true;
  apps.fdroid.enable = true;

  # ccache.enable = true;

  signing.avb.enable = true;

  # apps.prebuilt = {
  #   aurora-store = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/com.aurora.store_73.apk";
  #         sha256 = "sha256-/U0tTPtKTXd2aTD3IsalJK+QzBx/+Kprgf6cKw/FMIo=";
  #       }
  #     );
  #     privileged = true;
  #     privappPermissions = [ "INSTALL_PACKAGES" ];
  #     packageName = "com.aurora.store";
  #   };
  #   syncup = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/com.siddarthkay.syncup_29628615.apk";
  #         sha256 = "sha256-FDfyRIqrUeT6PctMdeM8YL5NYzV9bHQVkLEWtJdKfBI=";
  #       }
  #     );
  #     packageName = "com.siddarthkay.syncup";
  #   };
  #   nix-on-droid = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/com.termux.nix_188037.apk";
  #         sha256 = "sha256-D2uoLWkpbDPGbuXRCqGEY+SVPCpsP9EOfneMLNrgMwM=";
  #       }
  #     );
  #     packageName = "com.termux.nix";
  #   };
  #   markor = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/net.gsantner.markor_163.apk";
  #         sha256 = "sha256-P58mDcPjKhKBy4gD7qb5Ju74l1efaKXTX5IlI5dLhLk=";
  #       }
  #     );
  #     packageName = "net.gsanter.markor";
  #   };
  #   keepassdx = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/com.kunzisoft.keepass.libre_44100.apk";
  #         sha256 = "sha256-p3nvkVbN0iEbTbOGLadYrE8CjTpL2UydQ42S7cRpRlQ=";
  #       }
  #     );
  #     packageName = "com.kunzisoft.keepass.libre";
  #   };
  #   thunderbird = {
  #     apk = (
  #       pkgs.fetchurl {
  #         url = "https://f-droid.org/repo/net.thunderbird.android_22.apk";
  #         sha256 = "sha256-wgg931iC48P1Ty8dQuWhCOqaLuxKT5UZ4+4LWXB+qhM=";
  #       }
  #     );
  #     packageName = "net.thunderbird.android";
  #   };
  # };

  stateVersion = "3";
}
