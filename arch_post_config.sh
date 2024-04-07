#!/bin/bash

# Installation
TMP_DIRECTORY="${HOME}/tmp"

# TODO: improve interation.

create_temp_directory () {
  if [[ ! -d "$TMP_DIRECTORY" ]]; then
	mkdir -p "$TMP_DIRECTORY"
  	echo 'tmp directory created'
  fi
  cd "$TMP_DIRECTORY"
}

install_paru () {
  if [[ ! -x $(command -v paru)  ]]; then
  	git clone https://aur.archlinux.org/paru.git
	cd paru
  	makepkg -si
  	# flip search order
  	paru --gendb
  	paru -c
  	# read about makepkg.conf
	echo 'paru successfully installed'
  else
  	echo 'paru is already installed -- skiping'
  fi
  cd "$TMP_DIRECTORY"
}

install_zsh () {
  # read about .zshrc
  # install zsh-completions (?)
  sudo pacman -S zsh --needed --noconfirm
  echo 'zsh successfully installed'
}

install_zsh_framework () {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then 
  	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  	echo 'oh-my-zsh successfully installed'
  else
  	echo 'oh-my-zsh is already installed --skiping'
  fi
}

install_programs () {
  # install some programs
  sudo pacman -S bitwarden obsidian --needed
  echo 'Programs successfully installed'
}

# Configurations

# Paths
ZSHRC_PATH="$HOME/.zshrc"
PACMAN_CONF_PATH='/etc/pacman.conf'

# Line numbers
ZSH_THEME_LINE=$(grep -m 1 -n 'ZSH_THEME=' "${ZSHRC_PATH}" | cut -d: -f1)
ZSH_PLUGIN_LINE=$(grep -m 1 -n '^[^#]*plugins=' "${ZSHRC_PATH}" | cut -d: -f1)
ZSH_OMZUPDATE_LINE=$(grep -m 3 -n 'zistyle' "$ZSHRC_PATH" | cut -d: -f1)

# General
ZSH_DEFAULT_THEME='robbyrussell'
ZSH_MY_THEME='gentoo'
PLUGINS="git zsh-syntax-highlighting"

config_pacman_conf() {
    # Enable colors in pacman
    sudo sed -i 's/^#Color/Color/' "${PACMAN_CONF_PATH}"
    echo 'Pacman colors enabled'
}

config_oh_my_zsh () {
    # Switching theme
    sed -i "${ZSH_THEME_LINE}s/${ZSH_DEFAULT_THEME}/${ZSH_MY_THEME}/" ${ZSHRC_PATH}
    echo "New ZSH_THEME ${ZSH_MY_THEME}"
    # Mode reminder omz:update
    sed -i "${ZSH_OMZUPDATE_LINE}s/# zstyle/zstyle/" "$ZSHRC_PATH"
    echo 'OMZ remider update mode enabled'
}

install_zsh_syntax_highlighting() {
	if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"   ]]; then    
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		sed -i "${ZSH_PLUGIN_LINE}s/git/${PLUGINS}/" ${ZSHRC_PATH}
		echo "zhs-syntax-highlighting configured"
	else
		echo 'zsh-syntax-highlighting is already installed -- skipping'
	fi
}

create_temp_directory
install_zsh
config_pacman_conf
install_paru
install_zsh_framework
config_oh_my_zsh
install_zsh_syntax_highlighting
install_programs
