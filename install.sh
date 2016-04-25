
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

if ask "Install symlink for .zshrc?" Y; then
  ln -sf ${dir}/.zshrc ${HOME}/.zshrc
  ln -sf ${dir}/.aliases.sh ${HOME}/.aliases.sh
fi

if ask "Install symlink for .config/termite?" Y; then
  ln -sfn ${dir}/.config/termite ${HOME}/.config/termite
fi

if ask "Install symlink for .config/nvim?" Y; then
  ln -sfn ${dir}/.config/nvim ${HOME}/.config/nvim
fi
