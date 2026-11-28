# Try-style experiment navigator (https://github.com/tobi/try)
# Shell integration for the `just try` module in ~/dev/temp.
#
# Creates the `jt` function:
#   jt            # pick and cd
#   jt brew       # filtered pick
#   jt path brew  # print the path (no cd)
#   jt latest     # cd to the most recently updated
#   jt list       # recency listing
#   jt new <name> [description]
#   jt mv <old> <new>
#   jt rm <target>
#   jt root
#   jt -

eval "$(just --justfile "$HOME/dev/temp/justfile" try init --zsh)"
