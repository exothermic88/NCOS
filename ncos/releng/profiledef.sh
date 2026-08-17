#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="ncos"
iso_label="ncos_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="NCOS <https://archlinux.org>"
iso_application="NCOS Live ISO"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="ncos"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19' '-b' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/etc/gshadow"]="0:0:0400" 
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/bin/theme-select.sh"]="0:0:755"
  ["/usr/bin/theme-select-previous.sh"]="0:0:755"
  ["/usr/bin/toggle_light_dark"]="0:0:755"  
  ["/usr/bin/multiboot-toggle"]="0:0:755"
  ["/usr/bin/wallcycle.sh"]="0:0:755"
  ["/usr/bin/wallselect.sh"]="0:0:755"
  ["/usr/bin/theme-lib.sh"]="0:0:755"
  ["/usr/bin/auto-snapshot"]="0:0:755"
)
