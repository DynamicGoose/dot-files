# dot-files

My multi-host NixOS flake!

## Features

- **Flakes:** dependency version management
- **Home Manager:** user software configuration
- **nix-ld:** run dynamically linked binaries
- **nh:** nice NixOS cli helper with rebuild dependency graph
- **development shells:** built-in shells for some development environments
- **multi-host config:** configure multiple hosts easily through the custom config options, described in [`options.md`](./options.md)
- **lib:** lib module with some useful functions

## Sofware

- OS: [**`NixOS`**](https://nixos.org/)
- Compositor: [**`Niri`**](https://github.com/YaLTeR/niri)
- Bar: [**`Waybar`**](https://github.com/Alexays/Waybar)
- Theme: [**`Graphite (black variant)`**](https://github.com/vinceliuice/Graphite-gtk-theme)
- Icons: [**`Papirus-Dark`**](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- Shell: [**`Nushell`**](https://www.nushell.sh/)
- Promt: [**`Starship`**](https://starship.rs/)
- Terminal: [**`Kitty`**](https://sw.kovidgoyal.net/kitty/)
- Editor: [**`Helix`**](https://helix-editor.com/)

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

1. After setting up your hosts run `copy_config.sh`:
```shell
./copy_config.sh
```
2. For the first rebuild with this config rebuild like this:
```shell
sudo nixos-rebuild boot --install-bootloader --flake /etc/nixos#<config-you-want-to-build>
```
Afterwards, you can run `sudo nixos-rebuild switch|boot|etc.` like normal.

#### nh

After the first build you can also use `nh`:

1. Set `modules.programs.nh.configPath` to your `/path/to/nixos-config` before your first rebuild. (default is `/home/${username}/git/dot-files`)
2. Rebuild the system with `nh os switch|boot|etc`.

### Development Shells

In the `shells` directory, there are also a couple of nix shells for different usecases. You can enter the default dev shell with `nix develop`.  
Other shells can be invoked as you would expect. E.g.:
```shell
nix develop .#nix
```

> [!WARNING]
> These shells cannot be used through `nix-shell`. This was a conscious decision because I wanted them to always be as reproducable as the rest of the system.

### Library Functions

This flake also provides library function similar to `lib` in nixpkgs. These can be used in other flakes.

**Currently, these functions are provided:**
- `lib.mkHost`: for more easily defining new hosts using this flake
- `lib.genHosts`: used in `flake.nix` and maps attribute sets onto `lib.mkHost`
- `lib.eachSystem`: defining stuff for all architectures
- `lib.mkVMApp`: making a vm app from a configuration

#### Usage Example

> This is taken from the `flake.nix` from [another of my projects](https://codeberg.org/DynamicGoose/magma-ecs).

```nix
{
  description = "Magma-ECS dev shell";

  inputs = {
    dot-files.url = "git+https://codeberg.org/DynamicGoose/dot-files.git";
  };

  outputs =
    { self, dot-files }:
    {
      devShells = dot-files.lib.eachSystem (pkgs: {
        default =
          let
            libPath =
              with pkgs;
              lib.makeLibraryPath [
                vulkan-loader
              ];
          in
          pkgs.mkShell {
            name = "magma-ecs";
            nativeBuildInputs = with pkgs; [
              rustc
              cargo
              gcc
              rust-analyzer
              rustfmt
              clippy
            ];

            buildInputs = with pkgs; [
              pkg-config
            ];

            LD_LIBRARY_PATH = "${libPath}";
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          };
      });
    };
}

```
