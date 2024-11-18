# dot-files

My multi-host NixOS flake!

## Usage

When setting up a host, that doesn't have a config yet, add a new entry to `nixosConfigurations` in `flake.nix`.
The entry should probably look like this:
```nix
new-host = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit inputs;
  };
  modules = [
    ./common.nix
    ./hosts/new-host/config.nix
    ./hosts/new-host/hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
};
```
Then create the appropriate files in `hosts/new_host/` (`hardware-configuration.nix`, `config.nix`).
> [!IMPORTANT]
> `flakes` and `nix-command` have to be enabled to rebuild the system using flakes.
> `nix.settings.experimental-features = ["nix-command" "flakes"];`

Afterwards, Just run `rebuild.sh`:
```bash
./rebuild.sh
```

> [!TIP]
> NixOS channels can be removed, because flakes don't rely on them. (`nix-channel`)
