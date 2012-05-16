*my personal dotfiles*

bash, git, npm, node.

## install

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
npm i
# or ./install
# pretty much the same
```

*`install.sh` script based on @isaac's dotfiles install script*

The install script will symlink the appropriate files in `.dotfiles` to your
home directory. Files (folders included) ending with `*.ln` will get symlinked.
note that previous files are backuped in `~/.dotfile_backup/` folder.

Any files ending with `.bash` in any of the repo subdirs is sourced by
the `.bashrc` [file](https://github.com/mklabs/dotfiles/blob/master/bash/bashrc.ln)

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
environment setup. Custom prompt defined in config.bash. This directory
is added to the `$PATH` variable, so any script file in this folder ends
up globally accessible.

## node dir

Includes simple bash function helpers to help working with node. Usually
related to documentation browsing and helpers to easily jump to a given
source file on joyent/node repo.

```sh
$ node --version
v0.6.1

$ node-docs fs fs.createReadStream
>> Open http://nodejs.org/docs/v0.6.1/api/fs.html#fs.createReadStream

$ node-docs vm
>> Open http://nodejs.org/docs/v0.6.1/api/vm.html

$ node-src readline 89
>> Open https://github.com/joyent/node/blob/v0.6.1/lib/readline.js#L89

$ node-src stream
>> Open https://github.com/joyent/node/blob/v0.6.1/lib/stream.js#L1
```

Both functions have a really limited amount of completion.

## npm dir

Can include a `.npmrc` file.

Same as git, includes an example file to be copied and tweaked to
`npm/npmrc.ln`

Same as node, defines a set of useful bash function helpers to view a
package readme (similar as npm docs, but bump the readme to the
console). May also create the according manpage dinamycally and view
this through man (https://github.com/kapouer/ronnjs should be installed
and globally available)

```sh
# simple wrapper to npm info <pkg> readme
$ npm-readme request
>> Bump mikeal/request readme to the console

$ npm-man request
>> Same but display readme as manpage
```

Works for any recently updated package on the npm registry (eg. `npm
info <pkg> readme` should return something)

## todo dir

`todo.txt` related configuration file and directory.
