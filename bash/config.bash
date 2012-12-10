
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"

# Add node / npm version in bash prompt
#
# nv=$(node --version)
# npmv=$(npm --version)
#
#PS1='\w \[\033[0;90m\]« $nv/$npmv » $(__git_ps1 " \[\033[0;36m\](%s)")\[\033[0m\] » \n\[\033[0;90m\]\$ \[\033[0;00m\]'

# without
PS1='\[\033[0;90m\]\u@\h\[\033[0;00m\] \W $(__git_ps1 "\[\033[0;90m\](%s)" )\[\033[0m\] '
