# NCOS

**NCOS** is an Arch Linux-based operating system featuring the **Cosmic** desktop environment designed to offer a smooth, modern, and customizable user experience.

## Features

- **Arch Linux Base**: Built on Arch Linux, NCOS provides a highly customizable and rolling-release environment.
- **Cosmic Desktop**: NCOS runs the Cosmic desktop environment, offering simplicity and functionality with modern UI elements.
- **Lightweight and Fast**: Optimized for performance, NCOS is designed to be fast and efficient, suitable for both low-end and high-end hardware.
- **Customizability**: Extensive options for customization, allowing you to tailor the desktop environment to your liking.

## Installation

To install NCOS, follow these steps:

1. [Download](https://drive.google.com/file/d/1RRfabf39XmMBy-XwTot0KzZ_2atPnyhk/view?usp=sharing) the latest NCOS ISO.
2. Create a bootable USB drive using tools like `Etcher` or `Rufus`.
3. Boot from the USB drive and follow the installation prompts.
4. After installation, log into NCOS and begin following the `Post-Installation Steps`.

## Post-Installation Steps

After installing NCOS, follow these steps to complete the setup:

### Run Post-Install Setup Script

1. Connect to a wifi network.
2. Open a terminal with `Super + t`.
3. Run the following commands:
```bash
cd /etc/NCOS/
sudo chmod +x ncos-setup.sh
./ncos-setup.sh
```
4. Follow the setup prompts
5. Reboot the system

## Getting Started

Once installed, you can start exploring the Cosmic desktop environment. NCOS comes with a minimal set of pre-installed applications, allowing you to customize your system the way you want.

### Documentation

For detailed instructions and tips on using NCOS, check out our [Wiki](#).


## Support

If you encounter any issues or have questions, feel free to open an issue on GitHub or join our [community forum](#).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
