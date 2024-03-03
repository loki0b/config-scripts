#!/bin/bash

# Post installation script

TMP_DIRECTORY="$HOME/tmp"

create_temporary_folder () {
    if [[ ! -d "$TMP_DIRECTORY" ]]; then
            mkdir -p "$TMP_DIRECTORY"
    fi
    cd "$TMP_DIRECTORY"
}

install_paru() {
    sudo pacman -S base-devel --needed --noconfirm
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    # Flip search order
    paru --gendb
    paru -c
    # see about makepkg.conf
    cd "$TMP_DIRECTORY"
}

install_zsh () {
    # read more about .zshrc
    # install zsh-completions (?)
    sudo pacman -S zsh --needed --noconfirm
}

install_oh_my_zsh() { 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # config oh-my-zsh
}

install_programs () {
    sudo pacman -S bitwarden obsidian --needed
    echo 'Programs installed success'
}

# Execute
create_temporary_folder
install_zsh
install_oh_my_zsh
install_paru
install_programs
