#! /usr/bin/bash
set -e

# Source: https://gist.github.com/davejamesmiller/1965569
ask() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi
    read -p "$1 [$prompt] " REPLY </dev/tty
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

dir=`pwd`

if ask "Install symlink for .config/fish?" Y; then
  ln -sfn ${dir}/fish ${HOME}/.config/fish
fi

if ask "Install symlink for .config/termite?" Y; then
  ln -sfn ${dir}/termite ${HOME}/.config/termite
fi

if ask "Install symlink for .config/nvim?" Y; then
  ln -sfn ${dir}/vim ${HOME}/.config/nvim
fi

if ask "Install symlink for ~/.vim?" Y; then
  ln -sfn ${dir}/vim ${HOME}/.vim
fi

if ask "Install symlink for .gitconfig?" Y; then
  ln -sfn ${dir}/git/gitconfig.ln ${HOME}/.gitconfig
fi
