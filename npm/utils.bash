


function npm-readme() {
  npm info $1 readme
}

function npm-man() {
  local dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  npm info $1 readme | cat $dirname/head.txt - \
   | sed "s/:page/$1/g" \
   | ronn > ./foo.txt

  man ./foo.txt && rm ./foo.txt
}

