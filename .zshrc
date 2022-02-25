############################
# Variables
############################
export GIT_DIRECTORY=/git   # should be /c/git or /git
DOTFILES=$GIT_DIRECTORY/dotfiles # Location of your dotfiles

############################
# Oh-my-zsh and Powerlevel10k prompt initialization
############################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

############################
# Configure ZSH Plugins
############################
# Set no underlining in syntax highlighting custom plugin
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Source plugins for git, conda, and syntax highlighting
plugins=(git conda-zsh-completion zsh-syntax-highlighting)

############################
# Source Oh-my-zsh
############################
source $ZSH/oh-my-zsh.sh

############################
# Configure VIM keybindings for command line editing
############################
# Turn on VIM mode
bindkey -v

# Set shorter keytimeout to avoid typing lag
export KEYTIMEOUT=20

# Use vim keys in tab complete menu:
# This means you can't type with [h,j,k,l] in menus
# In Menu:
#     h -> go left in menu
#     j -> go down in menu
#     k -> go up in menu
#     l -> go right in menu
# Always:
#    kj -> typing 'kj' quickly enters VIM command mode (same as Escape key)
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Change cursor shape based on current VIM mode
# Use beam cursor for insert mode and block cursor for command mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} == '' ]] ||
         [[ $1 == 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}

# Set VIM mode as 'insert' on initial load and use beam shape cursor
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' #use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ; } # use beam shape cursor for each new prompt

############################
# Initialize Anaconda 
############################
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ross/.conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ross/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/ross/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/ross/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

############################
# Initialize NVM
############################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Explicityly set history file
export HISTFILE=$HOME/.zsh_history

############################
# Source the shared configuration files
############################
source $DOTFILES/git.sh
source $DOTFILES/ember.sh
source $DOTFILES/python.sh
source $DOTFILES/shell.sh
source $DOTFILES/windows.sh
[ -f $DOTFILES/custom.sh ] && $DOTFILES/custom.sh

############################
# Set up p10k configure command to customize prompt
############################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
