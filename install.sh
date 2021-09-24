#!/bin/bash

# Configurables
PKGS=(git curl wget vim zsh tmux)
INSTALL_ANACONDA=true
ANACONDA_VERSION=2021.05-Linux-x86_64
INSTALL_ROOT=$HOME/software/install

# Check for Fedora or Ubuntu, these are only supported systems so far
which dnf > /dev/null && {
    PKG_MANAGER="dnf"
    C_PKGS=(gcc gcc-c++ kernel-devel)
}

which apt-get > /dev/null && {
    PKG_MANAGER="apt-get"
    C_PKGS=(build-essential)
}

# Install system level packages with pkg manager
sudo $PKG_MANAGER install $PKGS $C_PKGS

# Check for existing configs and rename to save without deleting
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.old
[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.old
[[ -d ~/.zsh ]] && mv ~/.zsh ~/.zsh.old
[[ -d ~/.vim ]] && mv ~/.vim ~/.vim.old
[[ -f ~/.config/starship.toml ]] && mv ~/.config/starship.toml ~/.config/starship.toml.old
[[ -f ~/.p10k.zsh ]] && mv ~/.p10k.zsh ~/.p10k.zsh.old
[[ -f ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf.old

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# This assumes that OMZ root is in $HOME
ZSH_CUSTOM=~/.oh-my-zsh/custom

# Copy new config files to $HOME. This must be done after installing OMZ to keep .zshrc current
cp .zshrc ~
cp .vimrc ~
cp .p10k.zsh ~
cp .tmux.conf ~
cp config/starship.toml ~/.config/starship.toml
cp -r .zsh ~
cp -r .vim ~

# Clone custom plugins for syntax highlighting, conda completion, and powerlevel10k prompt
git clone https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Run PlugInstall silently to set up vim plugins
vim +'PlugInstall --sync' +qa

# Clone custom nord theme for tmux
git clone https://github.com/arcticicestudio/nord-tmux.git ~/.tmux/themes/nord-tmux

# Get MesloLGS NF font -- need a nerd font for prompts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Install starship prompt, this is nice to have if you use bash cli at all
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Add line to source starship to end of .bashrc
echo "eval \"$(starship init bash)\"" >> ~/.bashrc

# Install Anaconda to the INSTALL_ROOT dir (set at top of page)
if [ "$INSTALL_ANACONDA" = true ] ; then
   # Make software install dir to place Anaconda in
   if [ ! -d $INSTALL_ROOT ] ; then
       echo "======= Creating ~/software/install directory ================="
       mkdir -p $INSTALL_ROOT
   fi
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
           Or use another dark theme, but note that the nord tmux theme 
           might not work as expected without Nord or Solarized Dark.
        4. Run the following commands
        4. Source zsh by running the command: 
             $ zsh
        5. (Optional) Change shell to zsh from bash:
             $ sudo chsh -s $(which zsh)
      ============================================================================"
