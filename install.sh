#!/bin/bash

#
# coming from isaacs/dotfiles
# > https://raw.github.com/isaacs/dotfiles/master/install.sh
#
# and adapted here to work on linked directory and autoload
# per-topics `*.ln` files in this directory
#
# Once dotfiles are linked to the $HOME dir
#

# backup and link all the dotfiles within topics
! [ -d ~/.dotfile_backup ] && mkdir ~/.dotfile_backup


# Link them all
# -------------
#
# glob for files ending with .ln in the dotfile repo, they get symlinked
# to the $HOME directory.
#
for i in **/*.ln; do
  last=${i##*\/}
  dotfile=.${last%*.ln}

  echo "» About to backup and link dotfile: $dotfile..."
  if [ -e ~/$dotfile ]; then
    if ! ( rm -rf ~/.dotfile_backup/$dotfile || cp -r ~/$dotfile ~/.dotfile_backup/$dotfile ) || ! ( rm -rf ~/$dotfile || unlink ~/$dotfile ); then
      echo "  x Failed on $dotfile" > /dev/stderr
      exit 1
    else
      echo "  * $dotfile stored -> ~/.dotfiles_backup/$dotfile" > /dev/stderr
    fi
  fi
  echo "» Linking $i to your home directory -> ~/$dotfile";
  if ln -s $(pwd)/$i ~/$dotfile; then
    echo "  * Linked: $dotfile -> $i" > /dev/stderr
  else
    echo "  x Failed on $i\n" > /dev/stderr
    exit 1
  fi

  # append empty line between each dotfiles
  echo;
done


#
# Fetch them all
# --------------
#
# External programs that get either installed or updated when install is
# run
#

function install() {
  echo ... Installing $1: $2 ...
  curl $2 > ~/.dotfiles/bin/$1 -k
  chmod +x ~/.dotfiles/bin/$1
}

# Ack: http://betterthangrep.com/install/
install ack http://betterthangrep.com/ack-standalone

# nave: https://github.com/isaacs/nave
install nave https://raw.github.com/isaacs/nave/master/nave.sh

# hub: https://github.com/defunkt/hub#standalone
install hub http://defunkt.io/hub/standalone
