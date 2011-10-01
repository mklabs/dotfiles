*my personal dotfiles*

includes both bash/zsh configuration, with similar defaults configuration.

these dotfiles are meant to be used in mac (mainly for the macvim stuff), although most of it will work in other
unix too.

they are centered around vim, git, npm and node.

## intro

> [Your dotfiles are how you personalize your system. These are mine.](https://github.com/holman/dotfiles#readme)

They're mostly inspired (hence the fork) by [@holman](https://github.com/holman/dotfiles)'s way of dealing
with its dotfiles, and zsh configuration. The per-topics thing kinda match my tastes. Also, I didn't know
shit about bash/zsh and dotfiles, and I wanted to setup my dotfiles from scratch (not really actually).

Most of these files are coming from other dotfiles' repository too.

For instance, the `install.sh` is heavily (well, it is the starting point actually) inspired by
[isaacs/dotfiles](https://github.com/isaacs/dotfiles ) install script. It's been slightly edited
to work with per-topics symlinked files (which are ending by `.ln` here)

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
# assuming you have hub installed!
git clone mklabs/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

or you may want to clone the repo in whatever place you prefer, and then symlink it to your `~/.dotfiles`

```sh
git clone github.com:mklabs/dotfiles.git ~/code/where/you/like/to/put/stuff
ln -s ~/code/where/you/like/to/put/stuff ~/.dotfiles
cd ~/code/where/you/like/to/put/stuff
./install.sh
```

The install script will symlink the appropriate files in `.dotfiles` to your
home directory. Files(folders included) ending with `*.ln` will get symlinked.
note that previous files are backuped in `~/.dotfile_backup/` folder.

The main file you'll probably want to edit right away is `zsh/zshrc.ln` or `bash/bashrc.ln`,
which sets up a few paths that'll be different on your particular machine.

This is where the files ending with either `*.bash` or `*.zsh` are included in the shell configuration.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your zsh environment.
- **topic/\*.bash**: Any files ending in `.bash` get loaded into your bash environment.
- **topic/\*.ln**: Any files ending in `*.ln` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `./install.sh`.
- **topic/\*.completion.bash**: Any files ending in `completion.bash` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.
  (bash configuration autoloads them anyway).

## includes

* fancy command line prompt with node/npm version + git info: `17:56 ~/.dotfiles «v0.4.12/1.0.23» (master) »`
  * (time in 24-hour, current working directory, node/npm version, git information)
* npm completion
* git completion
* basic git configuration I enjoy using, and alias to some log and status command.
* [defunkt/hub](https://github.com/defunkt/hub) wrapper
* vim basic configuration ([janus](https://github.com/carlhuda/janus)' one) + pathogen and a small set of [plugins](https://github.com/mklabs/dotfiles/blob/master/.gitmodules)
* some alias
* .. and some other stuff, but not many

## node stuff

A few
[functions](https://github.com/mklabs/dotfiles/blob/mine/node/docs.bash)
related to the [node documentation](node documentation). The repo
includes the api markdown files in `node/doc/api`. It also includes the
generated manpage from these, using [kapouer/ronnjs](https://github.com/kapouer/ronnjs),
a port of [rtomayko/ronn](http://github.com/rtomayko/ronn). npm uses it to provides these
beautiful command line documentation.

* node-docs: Open the node api in the default browser for the current
  node version to the optional section.
* node-md: Output the markdown content (a simple cat)
* node-man: Open the according manpage, generated from markdown content.

```sh
node-docs                         # open http://nodejs.org/docs/v0.4.8/api/all.html
node-docs fs                      # http://nodejs.org/docs/v0.4.8/api/fs.html
node-docs fs fs.createReadStream  # http://nodejs.org/docs/v0.4.8/api/fs.html#fs.createReadStream
```

```sh
node-md                           # raw output https://raw.github.com/joyent/node/master/doc/api/_toc.markdown
node-md fs                        # https://raw.github.com/joyent/node/master/doc/api/fs.markdown
node-md path                      # https://raw.github.com/joyent/node/master/doc/api/path.markdown
```

```sh
node-man                          # open the toc manpage
node-man fs                       # open the fs manpage
node-man vm                       # open the vm manpage
```

or using man directly, `node/man` is added to the MANPATH environment variable by `bash/env.bash` or `zsh/env.zsh`.

```sh
man node-http
man node-globals
```

Note that each of these functions provides a realy basic completion support, just enough to make my life easier reading through the doc.

```sh
21:40:52  ~  «v0.4.8/1.0.27»  » node-man <tab><tab>
_toc             appendix_2       crypto           events           https            os               readline         string_decoder   tty              zlib
addons           assert           debugger         fs               index            path             repl             synopsis         url
all              buffers          dgram            globals          modules          process          stdio            timers           util
appendix_1       child_processes  dns              http             net              querystring      streams          tls              vm
```

#### node-docs

## prompts

basic prompt: `23:15:09  ~/.dotfiles  «v0.4.8/1.0.27»  (master) »`

[npm completion](http://npmjs.org/doc/completion.html) is pretty neat..

> Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)

```sh
23:10:36  ~/.dotfiles  «v0.4.8/1.0.27»  (master) » npm <tab><tab>
adduser      cache        docs         find         home         install      ll           owner        publish      remove       run-script   set          tag          unlink       version
author       completion   edit         get          i            la           ln           pack         r            restart      s            start        test         unpublish    view
bin          config       explore      help         info         link         ls           prefix       rb           rm           se           stop         un           up           whoami
c            deprecate    faq          help-search  init         list         outdated     prune        rebuild      root         search       submodule    uninstall    update
```

```sh
23:15:09  ~/.dotfiles  «v0.4.8/1.0.27»  (master) » npm install <tab>
Display all 4196 possibilities? (y or n)
```

> "What, 4196 possibilities ?"

```sh
23:15:09  ~/.dotfiles  «v0.4.8/1.0.27»  (master) » npm install hook<tab>
hook                 hook.io-browser      hook.io-feed         hook.io-logger       hook.io-repl         hook.io-twilio       hook.io-webserver
hook.io              hook.io-couch        hook.io-helloworld   hook.io-mailer       hook.io-request      hook.io-twitter      hook.io-ws
hook.io-boxcar       hook.io-cron         hook.io-irc          hook.io-pinger       hook.io-sitemonitor  hook.io-webhook      hooks
```

Oh my..

[git completion](https://raw.github.com/git/git/master/contrib/completion/git-completion.bash)

```sh
23:15:09  ~/.dotfiles  «v0.4.8/1.0.27»  (master) » git config color.<tab>
color.branch               color.branch.remote        color.diff.meta            color.diff.whitespace      color.interactive.prompt   color.status.changed       color.status.updated
color.branch.current       color.diff                 color.diff.new             color.interactive          color.pager                color.status.header        color.ui
color.branch.local         color.diff.commit          color.diff.old             color.interactive.header   color.status               color.status.nobranch
color.branch.plain         color.diff.frag            color.diff.plain           color.interactive.help     color.status.added         color.status.untracked
```

```sh
00:03:28  ~/.dotfiles  «v0.4.8/1.0.27»  (mine*+) » git --<tab>
--bare        --exec-path   --git-dir=    --help        --no-pager    --paginate    --version     --work-tree=

00:03:28  ~/.dotfiles  «v0.4.8/1.0.27»  (mine*+) » git branch --<tab>
--abbrev=     --color       --contains    --merged      --no-abbrev   --no-color    --no-merged   --no-track    --track       --verbose

00:03:28  ~/.dotfiles  «v0.4.8/1.0.27»  (mine*+) » git diff --<tab>
--abbrev                --color                 --ext-diff              --ignore-space-change   --no-ext-diff           --patch-with-stat       --raw                   --summary
--base                  --color-words           --find-copies-harder    --inter-hunk-context=   --no-prefix             --patience              --shortstat             --text
--binary                --diff-filter=          --full-index            --name-only             --no-renames            --pickaxe-all           --src-prefix=           --theirs
--cached                --dst-prefix=           --ignore-all-space      --name-status           --numstat               --pickaxe-regex         --staged
--check                 --exit-code             --ignore-space-at-eol   --no-color              --ours                  --quiet                 --stat
```



