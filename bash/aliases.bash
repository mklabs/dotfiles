
alias tu='top -o cpu' # cpu
alias tm='top -o vsize' # memory

## g for short form of git status, same as git s
alias g="git status -s"

# convenient alias to resource the whole config
alias gg="source ~/.bashrc"

# ls aliases
alias ls='ls -hF'
alias ll='ls -lhF'
alias la='ls -la'
alias l='ls -lAhF'

alias get='wget --no-check-certificate'

alias t='todo -d ~/.dotfiles/todo/todo.cfg'

# One vim... Just one.
#
# This ensures any files get opened in a "remote" vim, one
# that were previously spawned (or create a new one if necessary). Opens the
# files in a new tab.
#
# mt to open with new tabs
# m otherwise to open them all as buffers (:ls)
#
# see :h remote

# gvim on nix / mvim on osx

gvim="gvim"
if [[ $(which gvim) == "" ]]; then
  gvim="mvim"
fi

alias m="$gvim --remote-silent"
alias mt="$gvim --remote-silent-tab"
