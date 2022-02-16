############################
# Better ls output
############################
alias ls="ls --color=auto -alhX"

############################
# Save timestamp in the history file
############################
export HISTTIMEFORMAT="%F %T "

############################
# Don't store duplicates
############################
export HISTCONTROL=ignoreboth:erasedups

############################
# Set a custom history file to allow sharing
############################
export HISTFILE=$DOTFILES/bash/.bash_history
