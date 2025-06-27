# Config Options

These are options that can be set in your own config to change some stuff for different hosts.

## Options

### `modules.configPath`
type: `string`  
default: `"~/git/dot-files"`  
possible values: `"/path/to/your/config/files"`  

Sets the path where `nh` and other utils look for your config.

### `modules.boot.deviceType`
type: `string`  
default: `"uefi"`  
possible values: `"uefi"`, `"removable"`, `"legacy"`  
  
Sets the boot configuration to be compatible with the desired device.

### `modules.desktop.plasma.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  

Enables the Plasma6 Desktop environment.

### `modules.displayManager.lightdm.enable`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  

Enables LightDM display manager.

### `modules.displayManager.sddm.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `true`  

Enables SDDM display manager.

### `modules.graphics.enable`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  
  
Enables graphics configuration.

### `modules.graphics.type`
type: `string`  
default: `"amd"`  
possible values: `"amd"`, `"intel"`, `"nvidia"`  
  
Sets the type of graphics card.

### `modules.graphics.nvidia.driverPackage`
type: `package`  
default: `config.boot.kernelPackages.nvidiaPackages.latest`  
possible values: see [here](https://nixos.wiki/wiki/Nvidia#Determining_the_Correct_Driver_Version)  
  
Sets the Nvidia GPU driver package.

### `modules.graphics.nvidia.rtx20`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  
  
Set to `false`, if your GPU is older than RTX 20-Series.

### `modules.graphics.nvidia.hybrid.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Enables Nvidia Optimus PRIME hybrid graphics for laptops.

### `modules.graphics.nvidia.hybrid.intelBusId`
type: `string`  
default: `""`  
possible values: see [here](https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29)  
  
Set Intel graphics bus ID.

### `modules.graphics.nvidia.hybrid.nvidiaBusId`
type: `string`  
default: `""`  
possible values: see [here](https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29)  
  
Set Nvidia graphics bus ID.

### `modules.graphics.nvidia.hybrid.amdBusId`
type: `string`  
default: `""`  
possible values: see [here](https://nixos.wiki/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_.28Mandatory.29)  
  
Set AMD graphics bus ID.

### `modules.powerManagement.tlp.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Enables tlp (for laptop power-management).

### `modules.powerManagement.ppd.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Enables power-profiles-daemon (for laptop power-management).

### `modules.porgrams.waybar.desktop`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Sets the desktop config for waybar.

### `modules.services.audio.enable`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  
  
Enables audio (pipewire).

### `modules.services.hypridle.desktop`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Sets the desktop config for hypridle (disables brightness changes and suspend)

### `modules.services.ssh.enable`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  
  
Enables ssh.

### `modules.services.ssh.server` 
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Determines if ssh should always be running, or only start when needed (true means always running).

### `modules.services.illuminanced.enable`
type `boolean`  
default: `false`  
possiblr values: `true`, `false`  

Enables illuminanced service to control display brightness based on ALS. This needs a device-specific config file `/home/<user>/.config/illuminanced.toml`

### `modules.virtualisation.enable`
type: `boolean`  
default: `true`  
possible values: `true`, `false`  

Enables virtualisation support with libvirtd and virt-manager.

### `modules.virtualisation.waydroid.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  

Enables Waydroid, whcih can be configured through `waydroid-helper`.
