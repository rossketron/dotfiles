#!/bin/bash

############################
# Variables (0 = false : 1 = true)
############################
# List of packages to install
INSTALL_PKGS=0
PKGS=(git curl wget vim zsh tmux) 

# Version of Anaconda package manager to install
INSTALL_CONDA=0
CONDA_VERSION=2021.11-Linux-x86_64

INSTALL_NVM=0
INSTALL_OMZ=0
INSTALL_TMUX_THEME=0

# Directory to install Anaconda and NVM (they will be hidden directories)
INSTALL_ROOT=$HOME

############################
# Install system packages listed in PKGS and C_PKGS
############################
((INSTALL_PKGS)) && sudo $PKG_MANAGER install $PKGS $C_PKGS

############################
# Rename existing config files to keep from losing
############################
[[ -f ~/.bashrc ]]    && mv ~/.bashrc    ~/.bashrc.old
[[ -f ~/.zshrc ]]     && mv ~/.zshrc     ~/.zshrc.old
[[ -f ~/.vimrc ]]     && mv ~/.vimrc     ~/.vimrc.old
[[ -f ~/.p10k.zsh ]]  && mv ~/.p10k.zsh  ~/.p10k.zsh.old
[[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.old

############################
# Install Oh-my-zsh if specified and set OMZ custom directory
# Clone custom plugins for syntax highlighting, conda completion, and powerlevel10k prompt
###########################
((INSTALL_OMZ)) && {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ZSH_CUSTOM=~/.oh-my-zsh/custom
  git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}

############################
# Copy new config files to $HOME. This must be done after installing OMZ to keep .zshrc current
############################
cp .bashrc    ~
cp .zshrc     ~
cp -r vim     ~/.vim
cp .vimrc     ~
cp .p10k.zsh  ~
cp .tmux.conf ~

############################
# Run PlugInstall silently to set up vim plugins
############################
vim +'PlugInstall --sync' +qa

############################
# Clone custom nord theme for tmux
############################
((INSTALL_TMUX_THEME)) && \
  git clone https://github.com/arcticicestudio/nord-tmux.git ~/.tmux/themes/nord-tmux

############################
# Get MesloLGS NF and Fira Code fonts
############################
if [ ! -d fonts ]; then
  mkdir fonts && cd fonts
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
  mkdir tmp && cd tmp
  wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
  unzip Fira_Code_v6.2.zip
  mv ttf/* ../fonts/
  cd ../
  rm -rf tmp
  cd ../
fi

############################
# Install Anaconda to INSTALL_ROOT
############################
((INSTALL_CONDA)) && {
  echo "======= Installing Anaconda3, Version: ${CONDA_VERSION} ================="
  wget https://repo.anaconda.com/archive/Anaconda3-$CONDA_VERSION.sh 
  bash Anaconda3-$CONDA_VERSION.sh -b -p $INSTALL_ROOT/.conda
}

############################
# Install NVM to $HOME
############################
((INSTALL_NVM)) && {
  echo "=================== Installing NVM  ======================="
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}

# Print instructions for finishing install of fonts and terminal settings
echo "================ Instructions for Completing Installation ==================
        1. Install all Meslo Font files downloaded to this directory by opening in 
           file viewer and clicking \'install\'
        2. Open terminal settings and change font to MesloLGS NF Regular
        3. Source zsh by running the command: 
             $ zsh
        5. (Optional) Change shell to zsh from bash:
             $ sudo chsh -s $(which zsh)
            --> Note that if using WSL, add the following to the end of your 
                ~/.bashrc to allow for changing the default shell (doesn't 
                really change it just loads zsh every time and is easy to 
                remove/comment out if need to use bash):
                [if -f $HOME/.zshrc] && source $HOME/.zshrc
      ============================================================================"
