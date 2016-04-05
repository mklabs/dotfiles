*dotfiles*

## Install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Overview

- `*.ln` - Files (folders included) ending with `*.ln` will get symlinked to $HOME directory (such as .ackrc, .bashrc etc.&)

- `.sh` - Any files ending with `.sh` is sourced by either `.bashrc` or `.zshrc`

Using the following snippet

```sh
# Load all the `.sh` files in `.dotfiles` topics
for i in ~/.dotfiles/**/*.sh; do
  if [ -e $i ]; then
    . $i
  fi
done

# Load all the `.sh` files in root folder
for i in ~/.dotfiles/*.sh; do
  if [ -e $i ]; then
    . $i
  fi
done
```
### ./install.sh

[install.sh](./install.sh) is script based on [@isaac's dotfiles install script](https://github.com/isaacs/dotfiles/blob/master/install.sh)

Will symlink the appropriate files in `.dotfiles` to the home directory.

The install script also clones in `rupa/z` repository, because it is so handy.

### ./bin

The `./bin` directory is used to put globally available scripts and programs. This directory is added to the $PATH.

### Git template

Git configuration includes a git template to init repositories from

    # init template, change this to your prefered git setup
    [init]
      templatedir = ~/.dotfiles/git/templates/default
