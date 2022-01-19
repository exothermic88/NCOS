#!/usr/bin/env bash
#-------------------------------------------------------------------------
#███╗   ██╗ ██████╗         ██████╗ ███████╗
#████╗  ██║██╔════╝        ██╔═══██╗██╔════╝
#██╔██╗ ██║██║             ██║   ██║███████╗
#██║╚██╗██║██║             ██║   ██║╚════██║
#██║ ╚████║╚██████╗███████╗╚██████╔╝███████║
#╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~
#touch "$HOME/.cache/zshhistory"
#git clone "https://github.com/ChrisTitusTech/zsh"
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
#ln -s "$HOME/zsh/.zshrc" $HOME/.zshrc

PKGS=(
'autojump'
'awesome-terminal-fonts'
'brave-bin' # Brave Browser
#'dxvk-bin' # DXVK DirectX to Vulcan
'github-desktop-bin' # Github Desktop sync
#'lightly-git'
#'lightlyshaders-git'
#'mangohud' # Gaming FPS Counter
#'mangohud-common'
'konsave'
#'nerd-fonts-fira-code'
#'nordic-darker-standard-buttons-theme'
#'nordic-darker-theme'
#'nordic-kde-git'
#'nordic-theme'
#'noto-fonts-emoji'
#'papirus-icon-theme'
'plasma-pa'
'ocs-url' # install packages from websites
#'sddm-nordic-theme-git'
'snapper-gui-git'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
'snap-pac'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1JkaWN6r5QgPlgBJXoEQDioh82YvlQiXI' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1JkaWN6r5QgPlgBJXoEQDioh82YvlQiXI" -O vf.knsv && rm -rf /tmp/cookies.txt

export PATH=$PATH:~/.local/bin
cp -r $HOME/NCOS/dotfile/* $HOME/.config/
#pip install konsave
konsave -i $HOME/vf.knsv
sleep 1
konsave -a vf

echo -e "\nDone!\n"
exit
