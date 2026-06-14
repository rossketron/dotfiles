########################################################
# Configure VIM keybindings for command line editing
########################################################
zstyle ':completion:*' menu select
zmodload zsh/complist

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
echo -ne '\e[5 q'                #use beam shape cursor on startup
preexec() { echo -ne '\e[5 q'; } # use beam shape cursor for each new prompt
