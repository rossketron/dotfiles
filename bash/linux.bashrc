export BROWSER=wslview

############################
# Open windows explorer here
############################
alias e="explorer.exe ."

############################
# Open current repo in github
############################
gh() {
  git remote -v | head -n 1 | awk -F "@" '{print $2}' | awk -F " " '{print $1}' | sed 's/:/\//g' | sed 's/.git$//g' | awk '{print "http://"$1}' | xargs wslview
}

############################
# Open current file in Windows
############################
alias view="wslview"
