# dot-files

My multi-host NixOS flake!

## Features

- **Flakes:** nix dependency version management
- **nix-wrapper-modules:** [nix wrappers](https://birdeehub.github.io/nix-wrapper-modules/) for user software configuration
- **Security:** Reasonably [hardened](https://saylesss88.github.io/nix/hardening_NixOS.html) system
- **nh:** [nh](https://github.com/nix-community/nh) is a nice NixOS cli helper with rebuild dependency graph
- **development shells:** built-in shells for some development environments
- **multi-host config:** configure multiple hosts easily through the custom config options, described in [`options.md`](./options.md)
- **lib:** lib module with some useful functions
- **robotnix:** used for [custom android builds](https://github.com/nix-community/robotnix)

## Sofware

- OS: [**`NixOS`**](https://nixos.org/)
- Compositor: [**`Niri`**](https://github.com/YaLTeR/niri)
- Shell: [**`Quickshell Config (goose-shell)`**](https://codeberg.org/DynamicGoose/goose-shell)
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
  <hostName> = {
    username = "user";
    userDescription = "probably your name (for display-manager)";
    # Other options you may want to change:
    # system (default: "x86_64-linux")
    # hostDir (default: hostName)
    # includeModules (default: homeManager, ${self}/default.nix, ${self}/hosts/${hostDir})
  };
  # ...
};
# ...
```
2. Create `default.nix` in `hosts/${hostName}/`. Import modules like `hardware-configuration.nix` or `config.nix` from there.
3. Have a look at [`options.md`](./options.md) for my custom configuration options.

### Setting Up Passwords

1. create password hash
```
mkpasswd --method=yescrypt <password> >> /home/<user>/secrets/<root|user>
```
2. Path to hashed passwords can be changed in [`modules/core/users.nix`](./modules/core/users.nix).

### Building the System

> [!TIP]
> If you want to enable Secure Boot, you have to put your computer's secure boot into setup mode in the bios, before rebuilding.
> Afterwards enable Secure Boot again.

1. For the first rebuild with this config rebuild like this:
```shell
sudo nixos-rebuild boot --install-bootloader --flake ./path/to/flake#<config-you-want-to-build>
```
2. Afterwards, you can run `sudo nixos-rebuild switch|boot|etc. --flake ./path/to/flake#` like normal.

#### nh

After the first build you can also use `nh`:

1. Set `modules.programs.nh.configPath` to your `/path/to/nixos-config` before your first rebuild. (default is `/home/${username}/git/dot-files`)
2. Rebuild the system with `nh os switch|boot|etc`.

### Android

A [robotnix](https://github.com/nix-community/robotnix) config is provided through the following flake output by default: `packages.${system}.mobile-gezaa`.
Edit it through [`mobile.nix`](./mobile.nix).
See [robotnix documentation](https://docs.robotnix.org/welcome.html) for build instructions.

Currently this builds LineageOS for the OnePlus 6.

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
