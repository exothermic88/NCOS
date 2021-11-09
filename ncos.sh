#!/bin/bash
    
    bash 0-preinstall.sh
    arch-chroot /mnt /root/NCOS/1-setup.sh
    source /mnt/root/NCOS/install.conf
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/NCOS/2-user.sh
    arch-chroot /mnt /root/NCOS/3-post-setup.sh
