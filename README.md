# NC_OS Installer Script

---
## Create Arch ISO or Use Image

Download ArchISO from <https://archlinux.org/download/> and put on a USB drive with Ventoy,Etcher or rofus

## Boot Arch ISO

From initial Prompt type the following commands:

```
pacman -Sy git
git clone https://github.com/exothermic88/NCOS
cd NCOS
chmod +x ./ncos.sh
./ncos.sh
```

### System Description
This is completely automated arch install of the KDE desktop environment on arch using all the packages I use on a daily basis. 

## Troubleshooting

__[Arch Linux Installation Guide](https://github.com/rickellis/Arch-Linux-Install-Guide)__

### No Wifi

#1: Run `iwctl`

#2: Run `device list`, and find your device name.

#3: Run `station [device name] scan`

#4: Run `station [device name] get-networks`

#5: Find your network, and run `station [device name] connect [network name]`, enter your password and run `exit`. You can test if you have internet connection by running `ping google.com`. 

## Credits

- Original packages script was a post install cleanup script called ArchMatic located here: https://github.com/rickellis/ArchMatic

