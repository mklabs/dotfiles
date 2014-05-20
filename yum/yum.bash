# Should load only on yum like environment (rhel; centos, fedora, ...)

[ -e /usr/bin/yum ] || return;

alias ys="yum search"
alias yi="sudo yum install"
alias yay="sudo yum install -y"
