# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

function v
  set file (eval fzf -q "$argv")

  if [ -z $file ]
    echo "No file input"
  else
    vim $file
  end
end

function dotfiles
  cd ~/dotfiles

  set file (eval fzf -q "$argv")

  if [ -z $file ]
    echo "No file input"
  else
    vim $file
  end
end

function vimfiles
  cd ~/.vim

  set file (eval fzf -q "$argv")

  if [ -z $file ]
    echo "No file input"
  else
    vim $file
  end
end

function gt
  set file (eval git status -s | sed 's/ M //' | sed 's/?? //' | fzf -q "$argv")
  vim $file
end
