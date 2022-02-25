############################
# Give ls and grep some color
############################
alias ls="ls -hN --color=auto --group-directories-first"
alias la="ls -a --color=auto --group-directories-first"
alias lal="ls -al --color=auto --group-directories-first"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

############################
# History configuration
############################
export HISTFILE=$HOME/.zsh_history

# Don't store duplicates
export HISTCONTROL=ignoreboth:erasedups

# Don't let history get too big
export HISTSIZE=1000
export HISTFILESIZE=2000

# append to the history file, don't overwrite it
setopt APPEND_HISTORY
setopt SHARE_HISTORY

############################
# Easily search command history
############################
grab () {
  history | grep $1
}

############################
# Verbosity for file operations
############################ps
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias clr="clear"
alias c="code"
