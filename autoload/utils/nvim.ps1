# nvim
# Few utilities to start nvim with a different NVIM_APPNAME
function nvc {
  $env:NVIM_APPNAME = 'nvim.custom';
  nvim @args
}

function nvk {
  $env:NVIM_APPNAME = 'nvim.kickstart';
  nvim @args
}

function nvl {
  $env:NVIM_APPNAME = 'nvim.lazy';
  nvim @args
}

function nva {
  $env:NVIM_APPNAME = 'nvim.advent';
  nvim @args
}

function nvmk {
  $env:NVIM_APPNAME = 'nvim.mklabs-advent';
  nvim @args
}


