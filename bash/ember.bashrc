############################
# Clean and reinstall node dependencies
############################
alias depclean="rm -rf node_modules && yarn install"

############################
# Various Proxy
############################
alias es="ember s -spr false --proxy https://localhost:5001"
alias esc="ember s -spr false --proxy https://localhost:6001"