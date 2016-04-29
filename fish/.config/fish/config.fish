
set dir "$HOME/.config/fish/fish.d"

for file in $dir/*
  source $file
end
