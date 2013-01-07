
CHROME_DIR=$HOME/.config/google-chrome

function chrome() {
  google-chrome $@
}

function chrome-remote-debug() {
  echo google-chrome --user-data-dir=$CHROME_DIR-dev --remote-debugging-port=9222 --remote-debugging-frontend="http://$1/front-end/inspector.html"
  google-chrome --user-data-dir=$CHROME_DIR-dev --remote-debugging-port=9222 --remote-debugging-frontend="$1"
}
