
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"

nv=$(node --version)
npmv=$(npm --version)

PS1='\[\033[0;32m\]\T \[\033[0;00m\] \w \[\033[0;36m\] « $nv/$npmv » $(__git_ps1 " \[\033[0;33m\](%s)")\[\033[0m\] » '


