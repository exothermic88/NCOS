#!/bin/bash

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

prompt_yn(){
while true; do
    read yn
    case $yn in
        [Yy]* ) return 0;break;;
        [Nn]* ) return 1;break;;
        * ) echo "Please answer yes or no.";;
    esac
done
}

sudo clear

cd ~

echo -e "Welcome to the ${CYAN}${BOLD}NCOS ALPHA.${NONE}
		\nWould you like to run through the NCOS post-installation? (${GREEN}y${NONE}/${RED}n${NONE})"

if prompt_yn; then echo -e "${YELLOW}Stay close to your device as you may be prompted for configuration changes.\nPlease wait while NCOS optimizes your system...${NONE}\n" 
	sleep 10;
else exit;
fi 

sudo rm /etc/mkinitcpio.d/linux.preset
sudo cp /etc/mkinitcpio_NCOS/linux.preset /etc/mkinitcpio.d/

echo -e "${GREEN}${BOLD}------------------mkinitcpio CONFIGURED-----------------------------${NONE}\n"

sudo pacman -R --noconfirm gdm gnome-color-manager gnome-connections gnome-control-center gnome-maps gnome-software epiphany gnome-music malcontent totem gnome-shell-extensions gnome-shell

echo -e "${GREEN}${BOLD}-----------------------PACKAGES CLEANED------------------------${NONE}\n"

sudo pacman -Syu --noconfirm

echo -e "${GREEN}${BOLD}-----------------------SYSTEM UPDATED------------------------${NONE}\n"

echo -e "Would you like to replace the current version of ${CYAN}Visual Studio Code${NONE} with the Microsoft version of ${GREEN}Visual Studio Code${NONE}? (y/n)\n
(The ${CYAN}current version${NONE} is open source and may not be compatible with some of the microsoft extensions)\n
(The ${GREEN}microsoft version${NONE} is proprietary but will be compatible with all microsoft extensions)\n"

if prompt_yn; then 
	echo -e "${YELLOW}Replacing CODE OSS with Visual Studio Code...${NONE}\n"
	sudo pacman -R code --noconfirm
	yay -S visual-studio-code-bin --noconfirm; 
else echo -e "Keeping Code OSS\n";
fi 

yay -Syu --aur --noconfirm 

echo -e "${GREEN}${BOLD}-----------------------AUR PACKAGES UPGRADED------------------------${NONE}\n"

cd /etc/grub2-themes
sudo chmod +x install.sh
sudo ./install.sh -b -t vimix

echo -e "${GREEN}${BOLD}-----------------------BOOTLOADER THEME APPLIED------------------------${NONE}\n"

echo -e "${GREEN}${BOLD}Setup Complete:${NONE} Would you like to reboot your device(recommended)? (y/n)" 

if prompt_yn; then 
	echo -e "${GREEN}${BOLD}-----------------------NCOS POST-INSTALLATION SETUP COMPLETED------------------------${NONE}\n"
	echo -e "${YELLOW}REBOOTING IN 3."
	sleep 1
	echo -e "2."
	sleep 1
	echo -e "1.${NONE}"
	sleep 1
	reboot; 
else 
	echo -e "\n${GREEN}${BOLD}-----------------------NCOS POST-INSTALLATION SETUP COMPLETED------------------------${NONE}\n"
	exit;
fi 

