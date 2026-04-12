# Debug mode: Set DEBUG_ZSH=1 to see load times for each script

bUseDebug=([ "$DEBUG_ZSH" ])

script_dir="$HOME/.dotfiles"

directories=(
  'autoload/init'
  'autoload/completions'
  'autoload/utils'
  'autoload/after'
)

for dir in "${directories[@]}"; do
  for file in "$script_dir/$dir"/*.zsh; do
    [ -f "$file" ] || continue
    absPath=$(realpath "$file")
    
    if ! $bUseDebug; then
      . "$absPath"
      continue
    fi
    
    startTime=$(date +%s%N)
    . "$absPath"
    endTime=$(date +%s%N)
    
    elapsedMs=$(( (endTime - startTime) / 1000000 ))
    echo "... Loaded $absPath in ${elapsedMs} ms"
  done
done
