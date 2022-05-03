#!/bin/bash
#github-action genshdoc
#
# @file ArchTitus
# @brief Entrance script that launches children scripts for each phase of installation.

# Find the name of the folder the scripts are in
cd scripts

chmod +x startup.sh
chmod +x 0-preinstall.sh
chmod +x 1-setup.sh
chmod +x 2-user.sh
chmod +x 3-post-setup.sh 

cd ../

set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a
echo -ne "
-------------------------------------------------------------------------
		███╗   ██╗ ██████╗         ██████╗ ███████╗
	    	████╗  ██║██╔════╝        ██╔═══██╗██╔════╝
	       	██╔██╗ ██║██║             ██║   ██║███████╗
	      	██║╚██╗██║██║             ██║   ██║╚════██║
	        ██║ ╚████║╚██████╗███████╗╚██████╔╝███████║
	        ╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚══════╝
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Scripts are in directory named NCOS
"
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/NCOS/scripts/1-setup.sh )|& tee 1-setup.log
    if [[ ! $DESKTOP_ENV == server ]]; then
      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/NCOS/scripts/2-user.sh )|& tee 2-user.log
    fi
    ( arch-chroot /mnt $HOME/NCOS/scripts/3-post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

echo -ne "
-------------------------------------------------------------------------
		███╗   ██╗ ██████╗         ██████╗ ███████╗
	    	████╗  ██║██╔════╝        ██╔═══██╗██╔════╝
	       	██╔██╗ ██║██║             ██║   ██║███████╗
	      	██║╚██╗██║██║             ██║   ██║╚════██║
	        ██║ ╚████║╚██████╗███████╗╚██████╔╝███████║
	        ╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚══════╝
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Done - Please Eject Install Media and Reboot
"
