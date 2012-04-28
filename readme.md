*my personal dotfileas*

bash, vim, git, npm, node.

## install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
npm i
```

*`install.sh` script based on @isaac's dotfiles install script**

The install script will symlink the appropriate files in `.dotfiles` to your
home directory. Files(folders included) ending with `*.ln` will get symlinked.
note that previous files are backuped in `~/.dotfile_backup/` folder.

## vim config

vim/gvim config files based on [janus](https://github.com/carlhuda/janus) config.

### Vim Plugins

Plugins are managed via
[Pathogen](https://github.com/tpope/vim-pathogen). installation / update
script is based on [@brianleroux's quick-vim](https://github.com/brianleroux/quick-vim).

#### Linter

* [Tabular](http://vimcasts.org/episodes/aligning-text-with-tabular-vim/) Align declarations, equals signs, etc.
* [JSHint](https://github.com/manalang/jshint.vim) JSHint plugin

#### Syntax

* [JavaScript](https://github.com/pangloss/vim-javascript)
* [CoffeeScript](https://github.com/kchmck/vim-coffee-script)

#### Editing

* [surround](http://www.vim.org/scripts/script.php?script_id=1697)
* [tComment](http://www.vim.org/scripts/script.php?script_id=1173) auto comment

#### Snippets

* [SnipMate](http://www.vim.org/scripts/script.php?script_id=2540) Text-Mate like snippets
* [nodejs-snippets](https://github.com/jamescarr/snipmate-nodejs) node specific snippet for SnipMate.

#### Browsing

* [NERD_Tree](http://www.vim.org/scripts/script.php?script_id=1658) Tree filesystem browser

#### Colorschemes

* [ColorSamplePack] (http://www.vim.org/scripts/script.php?script_id=625)
* [Solarized](https://github.com/altercation/vim-colors-solarized)

#### Miscellaneous

* [Zencoding](http://www.vim.org/scripts/script.php?script_id=2981) Generate html structures from CSS-like syntax
