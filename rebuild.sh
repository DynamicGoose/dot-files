#!/zsr/bin/env bash

sudo rm -rf /etc/nixos/.
sudo cp -rf ./. /etc/nixos/
sudo nixos-rebuild switch
