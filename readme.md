*my personal dotfileas*

bash, vim, git, npm, node.

## install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
npm i
```

*`install.sh` script based on @isaac's dotfiles install script*

The install script will symlink the appropriate files in `.dotfiles` to your
home directory. Files (folders included) ending with `*.ln` will get symlinked.
note that previous files are backuped in `~/.dotfile_backup/` folder.

Any files ending with `.bash` in any of the repo subdirs is sources by
the `.bashrc` [file](https://github.com/mklabs/dotfiles/blob/master/bash/bashrc.ln)

## vim config

Vim plugins are managed via
[Pathogen](https://github.com/tpope/vim-pathogen). Installation / update
is based on the excellent [@brianleroux's
quick-vim](https://github.com/brianleroux/quick-vim) script. Plugins are
managed trhough a simple `bundle.txt` [file](https://github.com/mklabs/dotfiles/blob/master/bundles.txt).

[info](https://github.com/mklabs/dotfiles/tree/master/vim/#readme))


## git config

`git/gitconfig.ln.example` is a default configuration file for git. It
needs to be copied (and tweaked) to `git/gitconfig.ln` before running
the install script.

### git templates

[Some git init templates](https://github.com/mklabs/dotfiles/tree/master/git/templates#readme).

## bin dir

Includes commonly used standalone binary file (hub, nave, todo.txt)

## completion scripts

Are all stored in `completion/`, includes git, npm, todo.txt and grunt
completion. Other completions scripts may go in the
`completion/misc.bash` file.


## bash dir

Includes alias, symlinked bashrc file and some configuration /
environment setup. Custom prompt defined in config.bash.

## node dir

Includes simple bash function helpers to help working with node. Usually
related to documentation browsing and helpers to easily jump to a given
source file on joyent/node repo.

## npm dir

Can include a `.npmrc` file.

Same as git, includes an example file to be copied and tweaked to
`npm/npmrc.ln`

Same as node, defines a set of useful bash function helpers to view a
package readme (similar as npm docs, but bump the readme to the
console). May also create the according manpage dinamycally and view
this through man (https://github.com/kapouer/ronnjs should be installed
and globally available)

## todo dir

`todo.txt` related configuration file and directory.
