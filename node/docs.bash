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
  url="https://raw.github.com/joyent/node/master/doc/api/$1.markdown"
  curl $url
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
	open "http://nodejs.org/docs/$(node --version)/api/$1.html#$2"
}

