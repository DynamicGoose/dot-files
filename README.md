# dot-files

My multi-host NixOS flake!

## Usage

### Setting up a new host

> [!IMPORTANT]
> If you want to adapt these dot files for yourself be sure to configure your own hosts.

1. Add a new entry to `nixosConfigurations` in `flake.nix`:
```nix
# ...
nixosConfigurations = lib.genHosts = {
  new-host = {
    username = "new-host-user";
    userDescription = "probably your name (for display-manager)";
    # Other options you may want to change:
    # arch (default: "x86_64-linux")
    # hostname (default: config name)
  };
  # ...
};
# ...
```
2. Create `default.nix` in `hosts/new-host/`. Import modules like `hardware-configuration.nix` or `config.nix` from there.
3. Have a look at [`options.md`](./options.md) for my custom configuration options.

### Building the System

> [!IMPORTANT]
> `flakes` and `nix-command` have to be enabled to rebuild the system using flakes.
> `nix.settings.experimental-features = ["nix-command" "flakes"];`

1. After setting up your hosts run `copy_config.sh`:
```shell
./copy_config.sh
```
2. For the first rebuild with this config rebuild like this:
```shell
sudo nixos-rebuild boot --install-bootloader --flake /etc/nixos#<config-you-want-to-build>
```
Afterwards, you can run `sudo nixos-rebuild switch|boot|etc.` like normal.

> [!TIP]
> NixOS channels can be removed, because flakes don't rely on them. (`nix-channel`)

### Shells

In the `nix-shells` directory, there are also a couple of nix shells for different usecases
