#!/bin/bash


### UBUNTU OR DEBIAN DISTRIBUTION ###
sudo curl apt-get install open-vm-tools open-vm-tools-desktop \
     build-essential module-assistant \
     make gcc libimlib2-dev libxcb-res0-dev \
     libx11-xcv-dev libx11-dev libxft-dev libxinerama-dev xorg \
     ripgrep fasd xclip

# vmware-hgfsclient
# mkdir /mnt/hgfs/shared
# sudo vmhgfs-fuse .host:/shared /mnt/hgfs/shared -o allow_other
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# tmux source ~/.config/tmux/tmux.conf
# https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CommitMono.zip
