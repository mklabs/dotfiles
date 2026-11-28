# Debug mode: Set DEBUG_ZSH=1 to see load times for each script
bUseDebug=0
[[ -n "$DEBUG_ZSH" ]] && bUseDebug=1

script_dir="$HOME/.dotfiles"

_dotfiles_load() {
  local dir file absPath startTime endTime elapsedMs
  local -a directories=(
    'autoload/init'
    'autoload/priv'
    'autoload/completions'
    'autoload/utils'
    'autoload/after'
  )

  (( bUseDebug )) && zmodload -F zsh/datetime p:EPOCHREALTIME 2>/dev/null

  for dir in "${directories[@]}"; do
    # (N) applies null_glob to this glob only: an empty or missing directory
    # (e.g. autoload/priv, which is gitignored and machine-local) yields zero
    # iterations instead of a fatal NOMATCH that would abort the rest of .zshrc.
    for file in "$script_dir/$dir"/*.zsh(N); do
      [ -f "$file" ] || continue
      absPath="${file:A}"

      if (( ! bUseDebug )); then
        . "$absPath"
        continue
      fi

      startTime=$EPOCHREALTIME
      . "$absPath"
      endTime=$EPOCHREALTIME

      elapsedMs=$(( (endTime - startTime) * 1000 ))
      printf -v elapsedMs '%.1f' $elapsedMs
      print -u2 "... Loaded $absPath in ${elapsedMs} ms"
    done
  done
}

_dotfiles_load
unset -f _dotfiles_load
unset bUseDebug script_dir
