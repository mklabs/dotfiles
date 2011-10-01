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
  [[ -z "$1" ]] && return 1
  local dir="$HOME/.dotfiles/node/doc/api/$1.markdown"
  [[ -e "$dir" ]] || return 1
  cat $dir
}

# Open the node api for your current version to the optional section.
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
