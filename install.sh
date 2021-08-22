#!/bin/bash

# Congigurables
PKG_MANAGER="dnf"
PKGS=(git curl wget vim zsh)
INSTALL_ANACONDA=true
ANACONDA_VERSION=2021.05-Linux-x86_64
INSTALL_ROOT=$HOME/software/install

# Use this for Ubuntu gcc install
# C_PKGS=(build-essential)

# Use this for Fedora gcc install
C_PKGS=(gcc gcc-c++ kernel-devel)

# Install system level packages with pkg manager
sudo $PKG_MANAGER install $PKGS $C_PKGS

# This assumes that OMZ root is in $HOME
ZSH_CUSTOM=~/.oh-my-zsh/custom

# Check for existing configs and rename to save without deleting
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.old
[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.old
[[ -f ~/.zsh ]] && mv ~/.zsh ~/.zsh.old

# Copy new config files to $HOME
cp .zshrc ~
cp .vimrc ~
cp -r .zsh ~

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Clone custom plugins for syntax highlighting and conda completion
git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


# Make software install dir to place Anaconda in
if [ ! -d $INSTALL_ROOT ] ; then
    mkdir -p $INSTALL_ROOT
fi

# Install Anaconda
if [ "$INSTALL_ANACONDA" = true ] ; then
   if ! which conda > /dev/null ; then
       if [ ! -d $INSTALL_ROOT/anaconda3 ] ; then
            wget https://repo.anaconda.com/archive/Anaconda3-$ANACONDA_VERSION.sh 
            bash Anaconda3-$ANACONDA_VERSION.sh -b -p $INSTALL_ROOT/anaconda3
        fi
    fi
fi

# Change user shell to zsh
