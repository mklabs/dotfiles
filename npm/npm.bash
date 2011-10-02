
# few aliases

# alias to [npm docs](http://npmjs.org/doc/docs.html).
# nd <pkgname> to open the readme file in using `browser` config

alias nd="npm docs"

# function npm-readme
#
# automatically generate the project manpage, from the project's
# markdown readme. Lookup in `~/.npm/` cache folder.
#
# usage:
#
#     npm-readme <pkgname> <version>
#
function npm-readme {
  local pkg="$1" version="$2"
  [[ -z "$pkg" ]] && return 1
  [[ -z "$version" ]] && version=$(npm info --loglevel info $pkg version)

  local module="$HOME/.npm/$pkg/$version/package"
  local readme=$module
  local output="$HOME/.dotfiles/npm/.man.swp"
  local header="$pkg(3) -- version $version - path: $module
==========================================================================================================
## $pkg"

  echo "module > $module"

  [[ -r "$module/README.md" ]] && module="$module/README.md"
  [[ -r "$module/README.markdown" ]] && module="$module/README.markdown"
  [[ -r "$module/README.mkd" ]] && module="$module/README.mkd"
  [[ -r "$module/README" ]] && module="$module/README"

  local installed=$(la "$HOME/.npm/$pkg" | sed 's|^|    » |g')

  if [[ "$readme" == $module ]]; then
    if [[ -r "$module" ]]; then echo " ✗ no readme file in $pkg package for $version. Installed are
$installed"
    else echo " ✗ $pkg is in the npm registry, but $pkg@$version hasn't been installed yet, thus not in ~/.npm/$pkg/$version.

  Try running 'npm install $pkg' before 'npm-readme $pkg'.

  Packages need to be cached by npm.
  "
      echo " » Call npm cache add to grab the dependency pkg
      "
      npm cache add "$pkg"
      npm-readme $pkg
    fi
    return 1
  fi

  echo $module | pbcopy
  echo "$module copied to your clipboard"

  echo "$header" | cat - $module | node ~/.dotfiles/node_modules/.bin/ronn > "$output"
  man $output
}


# tab completion support for npm-readme command
#
# basic and simple, but provides just enough conveniency to use with
# npm-readme. Basically just provides completion based on the list of
# stuff in `~/.npm/` and `~/.npm/pkgname`.
#
_npm_readme_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ $prev == "npm-readme" ]]; then
      prev=""
      opts=$(ls "$HOME/.npm/" | sed 's|\/$||g')
      COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
      return 0
    fi

    if [[ -n "$prev" && -r "$HOME/.npm/$prev" ]]; then
      opts=$(ls "$HOME/.npm/$prev" | sed 's|\/$||g' | sed 's|latest||g')
      COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif [[ -n "$prev" && -n "$cur" ]]; then
      opts=$(ls "$HOME/.npm/$prev/$cur" | sed 's|\/$||g')
    fi

    return 0
}

complete -F _npm_readme_completion npm-readme



