*my personal dotfiles*

> Everything's built around topic areas ~ https://github.com/holman/dotfiles#topical

Using the following script to source every `.bash` files.

```sh
# Load all the `.bash` files in `.dotfiles` topics
for i in ~/.dotfiles/**/*.bash; do
  if [ -e $i ]; then
    . $i
  fi
done
```

- `*.ln` - Files (folders included) ending with `*.ln` will get symlinked.

- `.bash` - Any files ending with `.bash` in any of the repo subdirs is sourced by
the `.bashrc` [file](https://github.com/mklabs/dotfiles/blob/master/bash/bashrc.ln)


## Install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```
[install.sh](./install.sh) script based on [@isaac's dotfiles install script](https://github.com/isaacs/dotfiles/blob/master/install.sh)

Will symlink the appropriate files in `.dotfiles` to
the home directory.

---

`make z` - invoked by install target, clones and load https://github.com/rupa/z

---

File structure

    .
    |-- ack
    |   `-- ackrc.ln
    |-- bash
    |   |-- aliases.bash
    |   |-- bash_profile.ln
    |   |-- bashrc.ln
    |   |-- config.bash
    |   |-- env.bash
    |   `-- readme.md
    |-- bin
    |-- chrome
    |   `-- chrome.bash
    |-- completion
    |   |-- bower-completion.bash
    |   |-- git-completion.bash
    |   |-- grunt.bash
    |   |-- misc.bash
    |   |-- npm-completion.bash
    |   `-- readme.md
    |-- git
    |   |-- gitconfig.ln.example
    |   |-- readme.md
    |   `-- templates
    |       |-- default
    |       |   |-- description
    |       |   |-- hooks
    |       |   |   |-- pre-commit
    |       |   |   `-- pre-commit.sample
    |       |   `-- info
    |       |       `-- exclude
    |       `-- readme.md
    |-- install.sh
    |-- Makefile
    |-- package.json
    |-- readme.md
    |-- tmp
    `-- vim
        `-- aliases.bash

    12 directories, 26 files

---

~
