# Config Options

These are options that can be set in your own config to change some stuff for different hosts.

## Options

### `modules.boot.deviceType`
type: `string`  
default: `"uefi"`  
possible values: `"uefi"`, `"removable"`, `"legacy"`  
  
Sets the boot configuration to be compatible with the desired device.

### `modules.graphics.enable`
type: `boolean`
default: `true`
possible values: `true`, `false`

Enables graphics configuration.

### `modules.graphics.type`
type: `string`  
default: `"amd"`  
possible values: `"amd"`, `"intel"`  
  
Sets the type of graphics card.

### `modules.powerManagement.tlp.enable`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Enables tlp (for laptop power-management).

### `modules.users.username`
type: `string`  
default: `"gezaa"`  
possible values: anything  
  
Sets the username of the default user.

### `modules.users.fullName`
type: `string`  
default: `"Géza Ahsendorf"`  
possible values: anything  
  
Sets the name displayed on display managers etc..

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
  
Sets the desktop config for hypridle (disables brightness changes and susped)

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
