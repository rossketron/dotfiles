# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ross/.oh-my-zsh"
#
# Preferred editor for local and remote sessions
export EDITOR='vim'

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"


# Configure no underlining in syntax highlighting custom plugin
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Source plugins -> requires cloning conda and zsh completion repos manually
plugins=(git conda-zsh-completion zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Set up VIM mode
bindkey -v
export KEYTIMEOUT=20

# Use vim keys in tab complete menu:
# This means you can't type with [h,j,k,l] in menus
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Change cursor shape based on current Vi mode:
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
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate 'vi insert' as keymap, can remove if set bindkey -V elsewhere
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' #use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ; } # use beam shape cursor for each new prompt

# Set user aliases
[[ -f ~/.zsh/aliasrc ]] && source ~/.zsh/aliasrc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ross/software/install/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ross/software/install/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ross/software/install/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ross/software/install/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
