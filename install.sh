#!/bin/bash

########################################################
# Variables
########################################################

INSTALL_UV=1
INSTALL_OMZ=1
INSTALL_ASDF=1
INSTALL_PACKAGES=1

# List of packages to install
PACKAGES=(build-essentials git curl wget vim zsh tmux neovim lazygit ripgrep unzip)

########################################################
# Install system packages listed in PKGS and C_PKGS
########################################################
sudo apt update && sudo apt install -y ${PACKAGES[@]}

########################################################
# Rename existing config files to keep from losing
########################################################
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.old
[[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.old

########################################################
# Install Oh-my-zsh if specified and set OMZ custom directory
# Clone custom plugins for syntax highlighting, conda completion, and powerlevel10k prompt
########################################################
if [ $INSTALL_OMZ -eq 1 ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ZSH_CUSTOM=~/.config/oh-my-zsh/custom
  git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

########################################################
# Copy new config files to $HOME. This must be done after installing OMZ to keep .zshrc current
########################################################
cp .zshrc ~
cp .p10k.zsh ~
cp .tmux.conf ~

########################################################
# Clone custom nord theme for tmux
########################################################
git clone https://github.com/arcticicestudio/nord-tmux.git ~/.config/tmux/themes/nord-tmux

########################################################
# Get MesloLGS NF and Fira Code fonts
########################################################
rm -rf fonts
mkdir fonts && cd fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mkdir tmp && cd tmp
wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
unzip Fira_Code_v6.2.zip
mv ttf/* ../fonts
cd ../
rm -rf tmp
cd ../

########################################################
# Install ASDF and related plugins
########################################################
if [ $INSTALL_ASDF -eq 1 ]; then
  echo "============== Installing ASDF ============================="
  wget https://github.com/asdf-vm/asdf/releases/download/v0.19.0/asdf-v0.19.0-linux-amd64.tar.gz
  tar -xvf asdf-v0.19.0-linux-amd64.tar.gz
  sudo mv asdf /usr/bin/
  rm asdf asdf-v0.19.0-linux-amd64.tar.gz
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin add java https://github.com/halcyon/asdf-java.git
  asdf plugin add maven https://github.com/halcyon/asdf-maven
  asdf install nodejs latest
  asdf install java
  asdf install maven 3.9.16
fi

if [ $INSTALL_UV -eq 1 ]; then
  echo "============== Installing UV ============================="
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

########################################################
# Print instructions for finishing install of fonts and terminal settings
########################################################
echo "================ Instructions for Completing Installation ==================
        1. Install all Font files downloaded to this directory by opening in 
           file viewer and clicking \'install\'
        2. Open terminal settings and change font to MesloLGS NF Regular
        3. Source zsh by running the command: 
             $ zsh
        5. (Optional) Change shell to zsh from bash:
             $ sudo chsh -s $(which zsh)
      ============================================================================"
