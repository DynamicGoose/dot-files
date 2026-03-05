# NixOS Module Options


## [`options.modules.graphics.enable`](modules/hardware/graphics.nix#L9)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.graphics.type`](modules/hardware/graphics.nix#L13)

**Type:** `lib.types.str`

**Default:** `"amd"`

## [`options.modules.graphics.nvidia.driverPackage`](modules/hardware/graphics.nix#L18)

**Type:** `lib.types.package`

**Default:** `config.boot.kernelPackages.nvidiaPackages.latest`

## [`options.modules.graphics.nvidia.rtx20`](modules/hardware/graphics.nix#L22)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.graphics.nvidia.hybrid.enable`](modules/hardware/graphics.nix#L27)

enable hyprid mode for laptops

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.graphics.nvidia.hybrid.intelBusId`](modules/hardware/graphics.nix#L29)

**Type:** `lib.types.str`

**Default:** `""`

## [`options.modules.graphics.nvidia.hybrid.nvidiaBusId`](modules/hardware/graphics.nix#L33)

**Type:** `lib.types.str`

**Default:** `""`

## [`options.modules.graphics.nvidia.hybrid.amdBusId`](modules/hardware/graphics.nix#L37)

**Type:** `lib.types.str`

**Default:** `""`

## [`options.modules.desktop.plasma.enable`](modules/desktop/plasma.nix#L3)

Enable KDE Plasma 6 Desktop

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.boot.deviceType`](modules/core/boot.nix#L8)

**Type:** `lib.types.str`

**Default:** `"uefi"`

## [`options.modules.virtualisation.enable`](modules/core/virtualisation.nix#L10)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.virtualisation.virt-manager.enable`](modules/core/virtualisation.nix#L14)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.virtualisation.waydroid.enable`](modules/core/virtualisation.nix#L18)

Enable Waydroid

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.services.illuminanced.enable`](modules/services/illuminanced.nix#L9)

Enable illuminanced ALS service

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.displayManager.lightdm.enable`](modules/services/lightdm.nix#L8)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.powerManagement.tlp.enable`](modules/services/power-management.nix#L9)

enable tlp

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.powerManagement.ppd.enable`](modules/services/power-management.nix#L10)

enable power-profiles-daemon

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.powerManagement.hdparm.enable`](modules/services/power-management.nix#L11)

enable HDD power-saving

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.powerManagement.auto-cpufreq.enable`](modules/services/power-management.nix#L12)

enable auto-cpufreq, don't use with tlp

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.displayManager.greetd.enable`](modules/services/greetd.nix#L8)

**Type:** `lib.types.bool`

**Default:** `false`

## [`options.modules.services.ssh.enable`](modules/services/ssh.nix#L4)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.services.ssh.server`](modules/services/ssh.nix#L8)

always run ssh in background

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.displayManager.sddm.enable`](modules/services/sddm.nix#L7)

enable SDDM

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.services.hypridle.desktop`](modules/services/hypridle.nix#L9)

hypridle desktop config

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.services.audio.enable`](modules/services/audio.nix#L8)

**Type:** `lib.types.bool`

**Default:** `true`

## [`options.modules.programs.waybar.desktop`](modules/programs/waybar-UNUSED.nix#L9)

desktop config

**Type:** `boolean`

**Default:** `false`

**Example:** `true`

## [`options.modules.programs.nh.configPath`](modules/programs/nh.nix#L8)

**Type:** `lib.types.str`

**Default:** `"/home/${username}/git/dot-files"`

---
*Generated with [nix-options-doc](https://github.com/Thunderbottom/nix-options-doc)*
