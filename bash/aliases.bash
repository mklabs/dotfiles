
# todo: split this up by topics


alias tu='top -o cpu' # cpu
alias tm='top -o vsize' # memory

## git stuff
alias g="git status -s"
alias gg="source ~/.bashrc"

# update git hooks, have to remove file before running git init again to catch up changes
alias gi="git-init"

alias ls='ls -hF'
alias ll='ls -lhF'
alias la='ls -la'
alias l='ls -lAhF'

alias get='wget --no-check-certificate'

alias t='todo -d ~/.dotfiles/todo/todo.cfg'

# m to mvim current working directory
alias m='mvim .'

