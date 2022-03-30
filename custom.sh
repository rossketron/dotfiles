############################
# Configure aliases for ssh connections
############################
alias ssh-linode="ssh ross@139.177.205.136"
alias ssh-tellico="ssh cketron2@tellico.icl.utk.edu"
alias ssh-hydra="ssh cketron2@hydra22.eecs.utk.edu"

grab() {
    history | grep $1
}

grabf() {
    cat $1 | grep $2
}

