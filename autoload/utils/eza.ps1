# eza
# https://github.com/eza-community/eza
function lls { 
  eza -a --color=always --git @args
}

function ll { 
  #eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions @args
  eza -a --color=always --long --git --icons=always @args
}

function lll { 
  eza -a --color=always --long --git @args
}

function tree { 
  eza -a -T --level=2 @args
}

