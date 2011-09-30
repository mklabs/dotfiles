
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"

PS1='\[\033[0;32m\]\t \[\033[0;00m\] \w \[\033[0;36m\] «`node --version 2>/dev/null`/`npm --version 2>/dev/null`» $(__git_ps1 " \[\033[0;33m\](%s)")\[\033[0m\] » '


