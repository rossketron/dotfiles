#!/bin/bash

############################
# Variables
############################
# Set this to true to install system packages
INSTALL_PKGS=false
PKGS=(git curl wget vim zsh tmux) # List of packages to install

# Set this to true to install Anaconda package manager
INSTALL_ANACONDA=false
ANACONDA_VERSION=2021.11-Linux-x86_64

# Set this to true to install NVM node version manager
INSTALL_NVM=false

# Set this to true to install Oh-my-zsh
INSTALL_OMZ=false

# Set this to install Meslo Nerd Fonts
INSTALL_FONT=false

# Set the directory you wish to install Anaconda and NVM (they will be hidden directories)
INSTALL_ROOT=$HOME

# Customize VIM setup with plugins
INSTALL_VIM=false

############################
# Determine which package manager to use (only works for Fedora & Ubuntu currently)
############################
which dnf > /dev/null && {
    PKG_MANAGER="dnf"
    C_PKGS=(gcc gcc-c++ kernel-devel)
}

which apt-get > /dev/null && {
    PKG_MANAGER="apt-get"
    C_PKGS=(build-essential gcc-multilib)
}

############################
# Install system packages listed in PKGS and C_PKGS if specified
############################
if [ "$INSTALL_PKGS" = true ] ; then
  sudo $PKG_MANAGER install $PKGS $C_PKGS
fi

############################
# Rename existing config files to keep from losing
############################
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.old
[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.old
[[ -f ~/.p10k.zsh ]] && mv ~/.p10k.zsh ~/.p10k.zsh.old
[[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.old

############################
# Install Oh-my-zsh if specified and set OMZ custom directory
############################
if [ "$INSTALL_OMZ" = true ] ; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# This assumes that OMZ root is in $HOME
ZSH_CUSTOM=~/.oh-my-zsh/custom

############################
# Copy new config files to $HOME. This must be done after installing OMZ to keep .zshrc current
############################
cp .zshrc ~
cp .vimrc ~
cp .p10k.zsh ~
cp .tmux.conf ~

###########################
Clone custom plugins for syntax highlighting, conda completion, and powerlevel10k prompt
###########################
git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

############################
# Run PlugInstall silently to set up vim plugins
############################

if [ "$INSTALL_VIM" = true ] ; then
  vim +'PlugInstall --sync' +qa
fi

############################
# Clone custom nord theme for tmux
############################
if [ "$INSTALL_TMUX" = true ] ; then
  git clone https://github.com/arcticicestudio/nord-tmux.git ~/.tmux/themes/nord-tmux
fi

############################
# Get MesloLGS NF font -- need a nerd font for powerlevel10k prompt
############################
if [ "$INSTALL_FONT" = true ] ; then
  mkdir fonts && cd fonts
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
  cd ../
fi

############################
# Install Anaconda to INSTALL_ROOT if specified
############################
if [ "$INSTALL_ANACONDA" = true ] ; then
  if [ ! -d $INSTALL_ROOT ] ; then
    echo "======= Creating $INSTALL_ROOT directory ================="
    mkdir -p $INSTALL_ROOT
  fi
  if ! which conda > /dev/null ; then
    if [ ! -d $INSTALL_ROOT/.conda && ! -d $INSTALL_ROOT/.conda ] ; then
      echo "======= Installing Anaconda3, Version: ${ANACONDA_VERSION} ================="
      wget https://repo.anaconda.com/archive/Anaconda3-$ANACONDA_VERSION.sh 
      bash Anaconda3-$ANACONDA_VERSION.sh -b -p $INSTALL_ROOT/.anaconda3
    fi
  fi
fi

############################
# Install NVM to $HOME if specified
############################
if [ "$INSTALL_NVM" = true ] ; then
  if ! nvm -v > /dev/null ; then
    if [ ! -d $HOME/.nvm ] ; then
      echo "=================== Installing NVM  ======================="
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    fi
  fi
fi

# Print instructions for finishing install of fonts and terminal settings
echo "================ Instructions for Completing Installation ==================
        1. Install all Meslo Font files downloaded to this directory by opening in file viewer and clicking \'install\'
        2. Open terminal settings and change font to MesloLGS NF Regular
        3. Source zsh by running the command: 
             $ zsh
        5. (Optional) Change shell to zsh from bash:
             $ sudo chsh -s $(which zsh)
            --> Note that if using WSL, add the following to the end of your ~/.bashrc to 
                allow for changing the default shell (doesn't really change it just loads zsh
                every time and is easy to remove/comment out if need to use bash):

                `[if -f $HOME/.zshrc] && source $HOME/.zshrc`
      ============================================================================"
