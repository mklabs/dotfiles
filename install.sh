#!/bin/bash

# coming from isaacs/dotfiles
# > https://raw.github.com/isaacs/dotfiles/master/install.sh
#
# and adapted here to work on linked directory and autoload
# per-topics `*.ln` files in this directory

# submodules init/update
git submodule init && git submodule update

# install a few npm packages, may ends up in a package.json + start script
# installing ronn for the manpage stuff (`npm-readme`), npm/colors mainly for
# the custom vim/mate repl.
echo ' » installing ronn for the manpage npm-readme stuff, npm/colors mainly for the custom vim/mate repl \n\n'
! [ -d ~/.dotfiles/node_modules ] && npm install npm colors ronn

# backup and link all the dotfiles within topics
! [ -d ~/.dotfile_backup ] && mkdir ~/.dotfile_backup

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


