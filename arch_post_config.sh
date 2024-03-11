#!/bin/bash

# Installation
TMP_DIRECTORY="${HOME}/tmp"

create_temp_directory () {
  if [[ ! -d "$TMP_DIRECTORY" ]]; then
	  mkdir -p "$TMP_DIRECTORY"
  fi
  cd "$TMP_DIRECTORY"
  echo 'tmp dir created'
}


install_paru () {
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  # flip search order
  paru --gendb
  paru -c
  # read about makepkg.conf
  cd "$TMP_DIRECTORY"
  echo 'paru successfully installed'
}

instal_zsh () {
  # read about .zshrc
  # install zsh-completions (?)
  sudo pacman -S zsh --needed --noconfirm
  echo 'zsh successfully installed'
}

install_zsh_framework () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo 'Oh-my-zsh successfully installed'
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

# General
ZSH_DEFAULT_THEME='robbyrussell'
ZSH_MY_THEME='gentoo'
PLUGINS="git zsh-syntax-highlighting"

config_pacman_conf() {
    # Enable colors in pacman
    sed -i 's/^#Color/Color' "${PACMAN_CONF_PATH}"
    echo 'Pacman colors enabled'
}

config_oh_my_zsh () {
    # Switching theme
    sed -i "${ZSH_THEME_LINE}s/${ZSH_DEFAULT_THEME}/${ZSH_MY_THEME}/" ${ZSHRC_PATH}
    echo "New ZSH_THEME ${ZSH_MY_THEME}"
}

install_zsh_syntax_highlighting() {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sed -i "${ZSH_PLUGIN_LINE}s/git/${PLUGINS}/" ${ZSHRC_PATH}
    echo "zhs-syntax-highlighting installed"
}
