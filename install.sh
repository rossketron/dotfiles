#!/bin/bash

# Configurables
PKG_MANAGER="apt"
PKGS=(git curl wget vim zsh)
INSTALL_ANACONDA=true
ANACONDA_VERSION=2021.05-Linux-x86_64
INSTALL_ROOT=$HOME/software/install

# Use this for Ubuntu gcc install
C_PKGS=(build-essential)

# Use this for Fedora gcc install
#C_PKGS=(gcc gcc-c++ kernel-devel)

# Install system level packages with pkg manager
sudo $PKG_MANAGER install $PKGS $C_PKGS

# This assumes that OMZ root is in $HOME
ZSH_CUSTOM=~/.oh-my-zsh/custom

# Check for existing configs and rename to save without deleting
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.old
[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.old
[[ -f ~/.zsh ]] && mv ~/.zsh ~/.zsh.old


# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Copy new config files to $HOME. This must be done after installing OMZ to keep .zshrc current
cp .zshrc ~
cp .vimrc ~
cp -r .zsh ~

# Clone custom plugins for syntax highlighting, conda completion, and powerlevel10k prompt and fonts
git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k


# Make software install dir to place Anaconda in
if [ ! -d $INSTALL_ROOT ] ; then
    echo "======= Creating ~/software/install directory ================="
    mkdir -p $INSTALL_ROOT
fi

# Install Anaconda
if [ "$INSTALL_ANACONDA" = true ] ; then
   if ! which conda > /dev/null ; then
       if [ ! -d $INSTALL_ROOT/anaconda3 ] ; then
            echo "======= Installing Anaconda3, Version: ${ANACONDA_VERSION} ================="
            wget https://repo.anaconda.com/archive/Anaconda3-$ANACONDA_VERSION.sh 
            bash Anaconda3-$ANACONDA_VERSION.sh -b -p $INSTALL_ROOT/anaconda3
        fi
    fi
fi

# Print instructions for finishing install of fonts and terminal settings
echo "================ Instructions for Completing Installation ==================
        1. Install all Meslo Font files downloaded to this directory by opening in file viewer and clicking \'install\'
        2. Open terminal settings and change font to MesloLGS NF Regular
        3. Change theme to \'Solarized Dark\' and colors to \'Solarized\'
        4. Source zsh by running the command: 
             $ zsh
        5. (Optional) Change shell to zsh from bash:
             $ sudo chsh -s $(which zsh)
      ============================================================================"
