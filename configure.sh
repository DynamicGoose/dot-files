#!/usr/bin/env bash

sudo nix-channel --remove nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos


