*my personal dotfiles*

includes both bash/zsh configuration, with similar defaults
configuration.

these dotfiles are meant to be used in mac (mainly for the macvim
stuff), although most of it will work in other unix too.

They are centered around vim, git, npm and node.

## Intro

> [Your dotfiles are how you personalize your system. These are mine.](https://github.com/holman/dotfiles#readme)

They're mostly inspired (hence the fork) by
[@holman](https://github.com/holman/dotfiles)'s way of dealing with its
dotfiles, and zsh configuration. The per-topics thing kinda match my
tastes. Also, I didn't know shit about bash/zsh and dotfiles, and I
wanted to setup my dotfiles from scratch (not really actually).

Most of these files are coming from other dotfiles' repository too.

For instance, the `install.sh` is heavily (well, it is the starting
point actually) inspired by
[isaacs/dotfiles](https://github.com/isaacs/dotfiles ) install script.
It's been slightly edited to work with per-topics symlinked files (which
are ending by `.ln` here)

Most of these dotfiles are coming, or are directly inspired by some of
these repos you might want to check out (a loooot of good stuff in
there)

* https://github.com/mathiasbynens/dotfiles
* https://github.com/isaacs/dotfiles
* https://github.com/cloudhead/dotfiles
* https://github.com/rtomayko/dotfiles/
* https://github.com/ryanb/dotfiles
* https://github.com/TooTallNate/dotfiles
* https://github.com/robbyrussell/oh-my-zsh
* https://github.com/carlhuda/janus

## install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script will symlink the appropriate files in `.dotfiles` to your
home directory. Files(folders included) ending with `*.ln` will get symlinked.
note that previous files are backuped in `~/.dotfile_backup/` folder.

The main file you'll probably want to edit right away is `zsh/zshrc.ln`
or `bash/bashrc.ln`, which sets up a few paths that'll be different on
your particular machine.

This is where the files ending with either `*.bash` or `*.zsh` are
included in the shell configuration.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into the zsh environment.
- **topic/\*.bash**: Any files ending in `.bash` get loaded into the bash environment.
- **topic/\*.ln**: Any files ending in `*.ln` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in the dotfiles
  but still keep those autoloaded files in your the directory. These get
  symlinked in when you run `./install.sh`.

## includes

* custom prompt with node/npm version + git info: `5:56 ~/.dotfiles «v0.6.1/1.1.0-beta-10» (master) »`
* npm completion / git completion
* basic git configuration / alias.
* [defunkt/hub](https://github.com/defunkt/hub) wrapper
* vim
  * basic configuration ([janus](https://github.com/carlhuda/janus)' one)
  * pathogen
  * and a small set of [plugins](https://github.com/mklabs/dotfiles/blob/master/.gitmodules)
* few bash utilities and functions, [node helpers
  mainly](https://github.com/mklabs/dotfiles/blob/master/node/docs.bash)
(viewing docs / browsing source)

