#!/bin/bash

# Find the name of the folder the scripts are in
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
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
    ( bash startup.sh )|& tee startup.log
    source $SCRIPT_DIR/setup.conf
    ( bash 0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt /root/NCOS/1-setup.sh )|& tee 1-setup.log
    ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/NCOS/2-user.sh )|& tee 2-user.log
    ( arch-chroot /mnt /root/NCOS/3-post-setup.sh )|& tee 3-post-setup.log

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