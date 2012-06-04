
# Make .dotfiles/bin files executable
export PATH="$HOME/.dotfiles/bin:$PATH"

# add /opt/local/bin in front of /bin (to load updated verision of bash
export PATH="/opt/local/bin:$PATH"

# Colored `grep` output
export GREP_OPTIONS='--color=always'

# for `ls` (BSD, OSX)
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad


