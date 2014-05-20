
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"

# without
# PS1='\[\033[0;90m\]\u@\h\[\033[0;00m\] \W $(__git_ps1 "\[\033[0;90m\](%s)" )\[\033[0m\] '

export PS1="\[\e[00;37m\]\u@\h:\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]\\$ \[\e[0m\]"
