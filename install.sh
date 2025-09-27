#!/bin/bash

#
# Basic Setup Script
#
MAC=0
LINUX=0

# Initial config prompts
read -p "Does this computer expect a yubikey? (y/n)" YUBIKEY

# MacOS / OSX
if [[  $(uname -s) == "Darwin" ]]; then
    MAC=1
    echo "export MAC=1" | tee -a ./config_vars.sh

    echo "Accepting xcode license - root required"
    sudo xcodebuild -license accept
    brew update
    INSTALL_COMMAND='brew install'
fi

# Ubuntu
if [[ -n $(command -v lsb_release) ]]; then
    LINUX=1
    echo "export LINUX=1" | tee -a ./config_vars.sh
    sudo apt update
    INSTALL_COMMAND='sudo apt install -y'
fi

# Docker & Generic Linux
if [[  "$(uname -s)" =~ .*"Linux".* ]]; then
    LINUX=1
    echo "export LINUX=1" | tee -a ./config_vars.sh
    sudo apt update
    INSTALL_COMMAND='sudo apt install -y'
fi

if [[ $YUBIKEY = y ]]; then
  echo "export YUBIKEY_CLIENT=1" | tee -a ./config_vars.sh
  # Yubico ppa
  sudo apt-add-repository -y ppa:yubico/stable
  mkdir ~/.gnupg
  echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf
fi

# Misc setup BS
mkdir -p ${HOME}/.config

# Install packages
echo "${INSTALL_COMMAND} ${LINE}"
echo "Running: ${INSTALL_COMMAND} $(paste -sd ' ' ./packagelist.txt)"

${INSTALL_COMMAND} $(paste -sd ' ' ./packagelist.txt)

# Some packages are named differently for each system.
if [[ "${LINUX}" == 1 ]]; then
  ${INSTALL_COMMAND} $(paste -sd ' ' ./linux_only_packagelist.txt)

    # Linux master installer script
  ./linux_install.sh

elif [[ "${MAC}" == 1 ]]; then
  ${INSTALL_COMMAND} $(paste -sd ' ' ./mac_casklist.txt)
  ${INSTALL_COMMAND} $(paste -sd ' ' ./mac_only_packagelist.txt.txt)
fi

# Install Hack font
wget -O /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
if [[ "$LINUX" == 1 ]]; then
	echo "sudo unzip -o /tmp/Hack.zip -d /usr/local/share/fonts"
	sudo unzip -o /tmp/Hack.zip -d /usr/local/share/fonts
elif [[ "$MAC" == 1 ]]; then
	unzip -o /tmp/Hack.zip -d ${HOME}/Library/Fonts
fi

# Install Python packages 
# - break everything I WANT THESE EVERYWHERE ALL THE TIME
python3 -mpip install --break-system-packages --user $(paste -sd ' ' ./python_packagelist.txt)

# neovim config
./lsp_setup.sh

#
# Symlink dotfiles
#

rm -rf ~/.config/nvim
ln -s ${PWD}/neovim  ~/.config/nvim

# Set Home Directory
ln -sf ${PWD}/pylintrc ~/.pylintrc
ln -sf ${PWD}/tmux.conf ~/.tmux.conf
ln -sf ${PWD}/shellrc ~/.zshrc
ln -sf ${PWD}/shellrc ~/.bashrc

mkdir -p ${HOME}/.ipython/profile_default
ln -sf ${PWD}/ipython_config.py ${HOME}/.ipython/profile_default/ipython_config.py
