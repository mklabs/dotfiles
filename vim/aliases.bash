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
