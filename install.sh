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

if [[ $YUBIKEY = y ]]; then
  echo "export YUBIKEY_CLIENT=1" | tee -a ./config_vars.sh
  # Yubico ppa
  sudo apt-add-repository -y ppa:yubico/stable
fi

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
python3 -mpip install --user $(paste -sd ' ' ./python_packagelist.txt)

# neovim config
./lsp_setup.sh

#
# Symlink dotfiles
#

rm -rf ~/.config/nvim
ln -s ${PWD}/neovim  ~/.config/nvim

# Set Home Directory
rm ~/.pylintrc 2>/dev/null || true
rm ~/.tmux.conf 2>/dev/null || true
rm ~/.zshrc 2>/dev/null || true
rm ~/.bashrc 2>/dev/null || true

ln -s ${PWD}/pylintrc ~/.pylintrc
ln -s ${PWD}/tmux.conf ~/.tmux.conf
ln -s ${PWD}/shellrc ~/.zshrc
ln -s ${PWD}/shellrc ~/.bashrc
