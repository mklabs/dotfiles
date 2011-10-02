# node/docs.bash

#
# Collection of bash functions related to the node documentation,
# provides a few handy way to jump right away to the part of node
# api. Man pages are probably the best way to quickly jump to
# what you need, all in our beloved cli ♥
#


# Open the node api on HEAD to the arguments section,
# and bump markdown output to the console
#
# usage:
#     node-md fs
#     node-md path
#     node-md vm
#     node-md http
#
function node-md {
  local page="$1" dir
  [[ -z "$page" ]] && page="_toc"

  local dir="$HOME/.dotfiles/node/doc/api/$page.markdown"
  [[ -e "$dir" ]] || return 1
  cat $dir
}

# Open the node api for your current version to the optional section,
# using the default browser.
#
# usage:
#     node-docs fs fs.createReadStream
#     node-docs fs fs.createReadStream
#     node-docs path path.exists
#     node-docs vm
#     node-docs http http.createServer
#
function node-docs {
  local page="$1" section="$2"
  [[ -z "$page" ]] && page="all"
  [[ -z "$section" ]] || section="#$section"
  open "http://nodejs.org/docs/$(node --version)/api/$page.html$section"
}


# Open the node man page for the argument section.
#
# usage:
#     node-man fs
#     node-man path
#     node-man vm
#     node-man http
#
function node-man {
  local page="$1"
  [[ -z "$page" ]] && page="_toc"
  man "node-$page"
}

# Opens the source file on github for the argument node module and
# the current node version. Optionnal line args let you jump directly
# to the line number. This is really usefull when you get some stack trace,
# and whould like to see the corresponding code.
#
# use case: got an error
#     AssertionError: stdin must be initialized before calling setRawMode
#       at Object.setRawMode (tty_uv.js:37:10)
#       at new Interface (readline.js:89:9)
#       at Object.createInterface (readline.js:38:10)
#       ... etc
#
# Jump to the code:
#     node-src tty_uv 37
#     node-src readline 89
#     node-src readlline 38
#
function node-src {
  local page="lib/$1" line="L$2"
  [[ "$page" == "lib/" ]] && page="src/node"
  [[ "$line" == "L" ]] && line="L1"
  open "https://github.com/joyent/node/blob/$(node --version)/$page.js#$line"
}


# bash completion \o/
_node_api_completion() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="_toc addons all appendix_1 appendix_2 assert buffers child_processes crypto debugger dgram dns events fs globals http
  https index modules net os path process querystring readline repl stdio streams string_decoder synopsis timers tls tty url util vm zlib
  "
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}


complete -F _node_api_completion node-md
complete -F _node_api_completion node-docs
complete -F _node_api_completion node-man
complete -F _node_api_completion node-src

