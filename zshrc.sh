export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

# Pure prompt setup (thanks Sindre ;)) https://github.com/sindresorhus/pure
autoload -U promptinit && promptinit

PURE_PROMPT_SYMBOL="»"
PURE_GIT_UP_ARROW="↑"
PURE_GIT_DOWN_ARROW="↓"

prompt pure

# Oh my zsh plugins
plugins=(node npm git)

