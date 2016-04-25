# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

function v() {
  file=$(fzf -q "$*")

  if [[ -z $file ]]; then
    echo "No file input"
  else
    vim $file;
  fi
}

function dotfiles() {
  cd ~/.dotfiles

  file=$(fzf -q "$*")

  if [[ -z $file ]]; then
    echo "No file input"
  else
    vim $file;
  fi
}

function vimfiles() {
  cd ~/.vim

  file=$(fzf -q "$*")

  if [[ -z $file ]]; then
    echo "No file input"
  else
    vim $file;
  fi
}

function gt() {
  file=$(git status -s | sed 's/ M //' | sed 's/?? //' | fzf -q "$*")
  vim $file
}
