# Script to config my Arch distro.
# TODO install yay
# How to run the function within this script
install_yay

install_yay() {
    pacman -S --needed git base-devel
    # Maybe create a dir to save this sort of stuff
    git clone https://aur.archlinux.org/yay.git "$HOME"
    cd yay
    makepkg -si
    
    # First use 
    # Read more about
    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
}
