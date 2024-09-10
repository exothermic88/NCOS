# NCOS

**NCOS** is an Arch Linux-based operating system featuring the **Cosmic** desktop environment designed to offer a smooth, modern, and customizable user experience.

## Features

- **Arch Linux Base**: Built on Arch Linux, NCOS provides a highly customizable and rolling-release environment.
- **Cosmic Desktop**: NCOS runs the Cosmic desktop environment, offering simplicity and functionality with modern UI elements.
- **Lightweight and Fast**: Optimized for performance, NCOS is designed to be fast and efficient, suitable for both low-end and high-end hardware.
- **Customizability**: Extensive options for customization, allowing you to tailor the desktop environment to your liking.

## Installation

To install NCOS, follow these steps:

1. [Download](https://drive.google.com/file/d/1Exl-L10pOuGDt7YbpM-e4YPTnlcOB5yq/view?usp=sharing) the latest NCOS ISO.
2. Create a bootable USB drive using tools like `Etcher` or `Rufus`.
3. Boot from the USB drive and follow the installation prompts.
4. After installation, log in to experience NCOS.

## Post-Installation Steps

After installing NCOS, follow these steps to complete the setup:

### 1. Update mkinitcpio configuration

To update the mkinitcpio configuration, run the following commands:

```bash
sudo rm /etc/mkinitcpio.d/linux.preset
sudo cp /etc/mkinitcpio_NCOS/linux.preset /etc/mkinitcpio.d/
```

### 2. Update Grub Theme (Optional)

To apply the custom NCOS bootloader theme, run the following commands:

```bash
cd /etc/grub2-themes
sudo chmod +x install.sh
sudo ./install.sh -b -t vimix
```

## Getting Started

Once installed, you can start exploring the Cosmic desktop environment. NCOS comes with a minimal set of pre-installed applications, allowing you to customize your system from the ground up.

### Documentation

For detailed instructions and tips on using NCOS, check out our [Wiki](#).








## Support

If you encounter any issues or have questions, feel free to open an issue on GitHub or join our [community forum](#).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
