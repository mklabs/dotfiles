
# Make locally installed npm modules' bin files be available in $PATH
export PATH="./node_modules/.bin:$PATH"

# Make .dotfiles/bin files executable
export PATH="$HOME/.dotfiles/bin:$PATH"

# Make locally generated man pages for node available
export MANPATH="$HOME/.dotfiles/node/man:$MANPATH"

# Set the EDITOR after we set the PATH, in case of a locally compiled vim
export EDITOR="vim"

# Colored `grep` output
export GREP_OPTIONS='--color=always'

# for `ls` (BSD, OSX)
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad


