#!/usr/bin/env bash

sudo nix-channel --remove nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
printf "Choose Option:\n1) Desktop\n2) Laptop\n3) Removable\n"
read -p "> " option
if [ $option -eq 1 ]
then
sudo ln -s ./desktop/device-specific.nix /etc/nixos/device-specific.nix
else
if [ $option -eq 2 ]
then
sudo ln -s ./laptop/device-specific.nix /etc/nixos/device-specific.nix
else
if [ $option -eq 3 ]
then
sudo ln -s ./removable/device-specific.nix /etc/nixos/device-specific.nix
fi

sudo ln -s ./configuration.nix /etc/nixos/configuration.nix
exit 0
