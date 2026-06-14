########################################################
# Easily search command history
# But don't show too much each time
########################################################
grab() {
  if [[ "$1" = "-a" || "$1" = "--all" ]]; then
    return "$(history | grep "$2")"
  fi

  return "$(history | grep "$1" | head -n 10)"
}

########################################################
# Give ls and grep some color
########################################################
alias ls="ls -al --color=auto --group-directories-first"
alias grep='grep --color=auto'

########################################################
# I can't type clear and
# can't <ctrl>l is awkward
########################################################
alias clr="clear"
