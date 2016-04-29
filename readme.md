# :wrench: ~/.config

XDG compatible `.config` files, managed with [GNU stow](http://www.gnu.org/s/stow/).

## Install

    $ git clone https://github.com/mklabs/.config.git ~/dotfiles
    $ cd ~/dotfiles

Run `make install` or `./install.sh` and answer yes or no to `stow` a
particular set of config files.

    $ make install
    Install vim/nvim (https://github.com/mklabs/vimfiles) configuration files? [Y/n]
    Installing vim/nvim configuration
    Cloning into 'vim/.vim'...
    remote: Counting objects: 1012, done.
    remote: Total 1012 (delta 0), reused 0 (delta 0), pack-reused 1012
    Receiving objects: 100% (1012/1012), 357.89 KiB | 264.00 KiB/s, done.
    Resolving deltas: 100% (364/364), done.
    Checking connectivity... done.
    Install configuration files fish? [Y/n]
    LINK: .config/fish/fish.d => ../../src/mklabs/dotfiles/fish/.config/fish/fish.d
    Install configuration files git? [Y/n]
    LINK: .config/git => ../src/mklabs/dotfiles/git/.config/git
    LINK: .gitconfig => src/mklabs/dotfiles/git/.gitconfig
    Install configuration files gtk? [Y/n]
    LINK: .gtkrc-2.0-kde4 => src/mklabs/dotfiles/gtk/.gtkrc-2.0-kde4
    LINK: .config/gtk-3.0/settings.ini => ../../src/mklabs/dotfiles/gtk/.config/gtk-3.0/settings.ini
    LINK: .gtkrc-2.0 => src/mklabs/dotfiles/gtk/.gtkrc-2.0
    Install configuration files i3? [Y/n]
    LINK: .config/i3 => ../src/mklabs/dotfiles/i3/.config/i3
    Install configuration files i3blocks? [Y/n]
    LINK: .config/i3blocks => ../src/mklabs/dotfiles/i3blocks/.config/i3blocks
    Install configuration files nyaovim? [Y/n]
    LINK: .config/nyaovim/nyaovimrc.html => ../../src/mklabs/dotfiles/nyaovim/.config/nyaovim/nyaovimrc.html
    Install configuration files termite? [Y/n]
    LINK: .config/termite => ../src/mklabs/dotfiles/termite/.config/termite
    Install configuration files vim? [Y/n]
    LINK: .config/nvim => ../src/mklabs/dotfiles/vim/.config/nvim
    Install configuration files wallpapers? [Y/n]
    LINK: .config/wallpapers => ../src/mklabs/dotfiles/wallpapers/.config/wallpapers
    Install configuration files X11? [Y/n]
    LINK: .xinitrc => src/mklabs/dotfiles/X11/.xinitrc

**Uninstall**: Run `make uninstall` to unstow everything. Alternatively, you
can `stow -v -t $HOME -D thing` to unstow a particular thing.

## XDG

Most of the configuration files are stored in the `~/.config` directory, instead of `$HOME`.

## Stow

[GNU Stow](http://www.gnu.org/s/stow) is used to manage the installation of configuration files.

> GNU Stow is a symlink farm manager which takes distinct packages of software
> and/or data located in separate directories on the filesystem, and makes them
> appear to be installed in the same place.

> This is particularly useful for keeping track of system-wide and per-user
> installations of software built from source, but can also facilitate a more
> controlled approach to management of configuration files in the user's home
> directory, especially when coupled with version control systems.

    $ stow fish
    $ stow git

## Overview

### Fish

- `~/.config/fish/fish.d/alias.sh` - Defines few alias for git, ls, vim and docker.

- `~/.config/fish/fish.d/fzf.sh` - Defines functions to use fzf in specific
  directories like `~/dotfiles` and `~/.vim`, or specific context like `git status`.

- `~/.config/fish/fish.d/nvm.sh` - Function and alias to source nvm bash script
  using Bass.

### Git

- `~/.gitconfig` - General configuration for git, including author information
  (me), git init template, aliases and colors.

- `~/.config/git/teamplates` - Git template to init repo from (includes hooks /
  exclude attributes)

### Gtk

Configuration files for both gtk-2.0 and gtk-3.0. It configures the
environement to use Paper theme, with Flattr icons and Paper icon as a
fallback.

Font used is Droid Sans Mono 14px

### i3

Configuration file for i3, based and inspired by [@alexbooker
screencasts](https://youtu.be/ARKIwOlazKI?list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf)

### i3blocks

Configuration file for i3blocks, including scripts in `~/.config/i3blocks/scripts`.

A very simple status bar with:

- Disk usage
- Load avergae
- Date and time

### nyaovim

Gui font configuration for nyaovim, a GUI for nvim built on Electron.

### termite

Terminal configuration for Termite, with font set to `Droid Sans Mono 14` and
OceanicNext theme, using
[base16-builder](https://github.com/base16-builder/base16-builder) to generate
the theme.

### wallpapers

`~/.config/wallpapers` is used by `feh` in i3 config file to randomly pick a
png or jpg file to set as background on login or i3 reload.

This includes a list of https://www.reddit.com/r/wallpapers wallpapers
