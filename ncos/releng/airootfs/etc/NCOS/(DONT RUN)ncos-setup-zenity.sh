#!/bin/bash




cd ~

# Welcome message - requires user to click "OK"
#zenity --info --title="NCOS Setup" --text="Welcome to NCOS ALPHA." --width=400 --height=200

# Prompt to ask if user wants to run the setup script
if ! zenity --question --title="NCOS Setup" --text="Welcome to NCOS ALPHA.\nWould you like to run the post-installation process now?"; then
    exit
fi

fatal() {
    echo "FATAL ERROR: $@"
    exit 1
  }
  trap 'sudo -k' EXIT
  zenity --password | sudo -Sv || fatal "Unable to sudo"


# Displaying progress without requiring user interaction
(
echo "10" ; sleep 1  # Update progress to 10%
echo "# Optimizing your system..." ; sleep 1

# Visual Studio Code replacement prompt
if zenity --question --title="NCOS Setup" --text="Would you like to replace the current version of Visual Studio Code (open-source) with the Microsoft version?"; then
    echo "# Replacing CODE OSS with Visual Studio Code..." ; sleep 1
sudo pacman -Sy || fatal "Failed to synchronize package databases"
sudo pacman -R --noconfirm code || fatal "Failed to remove Code OSS"
yay -S visual-studio-code-bin --noconfirm || fatal "Failed to install Visual Studio Code"
else
    echo "# Keeping current version of Code OSS..." ; sleep 1
fi
echo "30" ; sleep 1  # Update progress to 30%

# Bootloader theme
echo "# Applying bootloader theme..." ; sleep 1
sudo cp /etc/NCOS/grub /etc/default/
cd /etc/NCOS/grub2-themes
sudo chmod +x install.sh
sudo ./install.sh -b -t vimix
echo "50" ; sleep 1  # Update progress to 50%

# mkinitcpio configuration
echo "# Configuring mkinitcpio..." ; sleep 1
sudo cp /etc/NCOS/linux.preset /etc/mkinitcpio.d/
sudo cp /etc/NCOS/mkinitcpio.conf /etc/
echo "65" ; sleep 1  # Update progress to 65%

# plymouth configuration
echo "# Configuring plymouth..." ; sleep 1
sudo cp -r /etc/NCOS/monoarch /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R monoarch
echo "80" ; sleep 1  # Update progress to 80%


# Package cleanup and system update
echo "# Cleaning packages and updating system..." ; sleep 1
sudo pacman -R --noconfirm gdm gnome-color-manager gnome-connections gnome-control-center gnome-maps gnome-software epiphany gnome-music malcontent totem gnome-shell-extensions gnome-shell
sudo pacman -Syu --noconfirm
yay -Syu --aur --noconfirm
echo "100" ; sleep 1  # Update progress to 100%

) |
zenity --progress --title="NCOS Setup" --text="Running setup..." --percentage=0 --width=400 --no-cancel --auto-close


#reboot
if zenity --question --title="NCOS Setup" --text="Setup complete. Would you like to reboot your device (recommended)?"; then
    (
    # Countdown for 5 seconds
    for i in {5..1}; do
        echo "# Rebooting in $i seconds..."
        sleep 1
    done
    ) | zenity --progress --title="Rebooting" --text="Preparing to reboot..." --percentage=0 --auto-close --no-cancel --width=400 --height=100
    
    sudo rm .local/share/applications/setup.desktop
    reboot
else
    sudo rm .local/share/applications/setup.desktop
    zenity --info --title="NCOS Setup" --text="NCOS post-installation setup completed." --timeout=3 --width=300 --height=100
fi