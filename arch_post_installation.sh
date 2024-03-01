#!/bin/sh
# Script to config my Arch distro.

# Functions
install_yay() {
    sudo pacman -S  git base-devel --needed --noconfirm
    git clone https://aur.archlinux.org/yay.git "$HOME"
    cd yay
    makepkg -si
    
    # First use 
    # Read more about
    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
}

# Execute
# TODO install yay
# TODO install zsh and oh-my-zsh and config
# TODO install
