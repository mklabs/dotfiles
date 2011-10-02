*my personal dotfiles*

includes both bash/zsh configuration, with similar defaults configuration.

these dotfiles are meant to be used in mac (mainly for the macvim stuff), although most of it will work in other
unix too.

they are centered around vim, git, npm and node (and man pages..)

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
git clone git://github.com/mklabs/dotfiles.git
cd ~/.dotfiles
git checkout mine
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

### node stuff

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
* node-src: Open the source (js) file on github, using current version,
  jumping to the optionnal line argument.

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

The `node-src` command opens the source file on github for the argument node module and
the current node version. Optionnal line args let you jump directly to the line number.

This is really usefull when you get some stack trace, and whould like to see the corresponding code.

use case: got an error

```sh
AssertionError: stdin must be initialized before calling setRawMode
  at Object.setRawMode (tty_uv.js:37:10)
  at new Interface (readline.js:89:9)
  at Object.createInterface (readline.js:38:10)
  ... etc
``

Jump to the code:

```sh
node-src tty_uv 37
node-src readline 89
node-src readlline 38
```

Note that each of these functions provides a realy basic completion support, just enough to make my life easier reading through the doc.

```sh
21:40:52  ~  «v0.4.8/1.0.27»  » node-man <tab><tab>
_toc             appendix_2       crypto           events           https            os               readline         string_decoder   tty              zlib
addons           assert           debugger         fs               index            path             repl             synopsis         url
all              buffers          dgram            globals          modules          process          stdio            timers           util
appendix_1       child_processes  dns              http             net              querystring      streams          tls              vm
```

### npm stuff

* `nd` alias to `npm docs` which open the package's readme file with the
  default browser. ('npm config get browser')

* [npm-readme](https://github.com/mklabs/dotfiles/blob/mine/npm/npm.bash): custom bash script to generate manpage for any installed
  npm packages, needs ronn installed.

The first arguments is the npm package we want to man the readme.

```sh
npm-readme browserify             # try to load man page for the latest browserify version
npm-readme npm                    # open the npm readme file in your man page viewer
npm-readme redis                  # open the latest redis readme in your man page viewer
```

Optionnaly, a second `version` arguments can be used to be more specific about the man page generated.

```sh
npm-readme dnode 0.7.5
npm-readme express 2.3.10
npm-readme express 2.4.4
npm-readme express 2.4.5
```

Man page are generated from the stuff in `~/.npm` which is the cache folder npm uses by default (`npm help cache`). If either a project does not provide a readme (readme.md, readme.mkd, readme.markdown), or the project@version is not already in the npm cache, this command will fail and try to explain why.

**tab completion too \o/**: performs tabs completion by looking up the `~/.npm` folder, supports pkg/version. does not perform registry tab completion like npm does.

```sh
06:09:23  ~  «v0.4.8/1.0.27»  » npm-readme <tab><tab>
Display all 172 possibilities? (y or n)
06:09:23  ~  «v0.4.8/1.0.27»  » npm-readme connect-<tab><tab>
connect-couchdb  connect-docco    connect-dojo     connect-form     connect-mongo    connect-redis
06:09:23  ~  «v0.4.8/1.0.27»  » npm-readme express<tab>
express           express-messages  express-mongoose  expresso

06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme c
chainsaw         cliff            coffeekup        commondir        concrete         connect-couchdb  connect-dojo     connect-mongo    contextify       cradle           creationix       ctrlflow
clean-css        coffee-script    colors           complete         connect          connect-docco    connect-form     connect-redis    couchapp         cradle-init      cssom            curry
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme coffee
coffee-script  coffeekup
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme b
backbone    bcrypt      browserify  burrito
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme h
h5eb                hamljs              hashish             hook                hook.io             hook.io-helloworld  hooks               html-minifier       htmlparser          http-server
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme j
jade     journey  jqtpl    jsdom
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme n
nabe                nconf               node-inspector      nodeunit            npm                 npm-docsite         nub
nake                nih-op              node-markdown       nopt                npm-deploy          npm-github-service  nvm
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme m
markdown        meta-test       mime            mkdirp          mongodb         mongoose        mongoose-auth   mongoose-types  mustache
06:12:51  ~  «v0.4.8/1.0.27»  » npm-readme express 2.
2.3.10  2.4.4   2.4.5   2.4.6
```

Running `npm-readme coffee-script` will open the corresponding man page, generated from the project readme and would normally output this. And this is somehing pretty cool, if you ask me.

```sh
COFFEE-SCRIPT(3)                                                                                                                                                            COFFEE-SCRIPT(3)

NAME
       coffee-script -- version 1.1.2 - path: /Users/mk/.npm/coffee-script/1.1.2/package

coffee-script
       =
                   {
                }   }   {
               {   {  }  }
                }   }{  {
               {  }{  }  }
              ( }{ }{  { )                   / |     / |/ |
            .- { { }  { }} -.               | |     __ | || | _
           (  ( } { } { } }  )              | |    /  \|  |  /  \/  \
           |-..________ ..-'|              | |___| (_) | | | ||  __/  __/
           |                 |               \_____\___/|_| |_| \___|\___|
           |                 ;--.
           |                (__  \            _____           _       _
           |                 | )  )          / ____|         (_)     | |
           |                 |/  /          | (___   ___ _ __ _ _ __ | |_
           |                 (  /            \___ \ / __| '__| | '_ \| __|
           |                 |/              ____) | (__| |  | | |_) | |_
           |                 |              |_____/ \___|_|  |_| .__/ \__|
            -....-'                                  | |
                                                               ||

         CoffeeScript is a little language that compiles into JavaScript.

         Install Node.js, and then the CoffeeScript compiler:
         sudo bin/cake install

         Or, if you have the Node Package Manager installed:
         npm install -g coffee-script
         (Leave off the -g if you don't wish to install globally.)

         Compile a script:
         coffee /path/to/script.coffee

         For documentation, usage, and examples, see:
         http://coffeescript.org/

         To suggest a feature, report a bug, or general discussion:
         http://github.com/jashkenas/coffee-script/issues/

         If you'd like to chat, drop by #coffeescript on Freenode IRC,
         or on webchat.freenode.net.

         The source repository:
         git://github.com/jashkenas/coffee-script.git

```

## prompts

basic prompt: `23:15:09  ~/.dotfiles  «v0.4.8/1.0.27»  (master) »`

Both npm/git completion are included and `source`-d in corredponding
bashrc/zshrc file.

* [npm completion](http://npmjs.org/doc/completion.html) is pretty neat..

> Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)

```sh
23:10:36  ~/.dotfiles  «v0.4.8/1.0.27»  (master) » npm <tab><tab>
adduser      cache        docs         find         home         install      ll           owner        publish      remove       run-script   set          tag          unlink       version
author       completion   edit         get          i            la           ln           pack         r            restart      s            start        test         unpublish    view
bin          config       explore      help         info         link         ls           prefix       rb           rm           se           stop         un           up           whoami
c            deprecate    faq          help-search  init         list         outdated     prune        rebuild      root         search       submodule    uninstall    update
```

The npm tab completion is incredibly powerful, using it feels really good. Supports tab completion for npm packages (from the repository), and pretty much any command/cli options. Really [impressive](https://github.com/isaacs/npm/blob/master/lib/completion.js).

* [git completion](https://raw.github.com/git/git/master/contrib/completion/git-completion.bash)

> The contained completion routines provide support for completing:
>
>    * local and remote branch names
>    * local and remote tag names
>    * .git/remotes file names
>    * git 'subcommands'
>    * tree paths within 'ref:path/to/file' expressions
>    * common --long-options


```sh
00:03:28  ~/.dotfiles  «v0.4.8/1.0.27»  (mine*+) » git --<tab>
--bare        --exec-path   --git-dir=    --help        --no-pager    --paginate    --version     --work-tree=

00:03:28  ~/.dotfiles  «v0.4.8/1.0.27»  (mine*+) » git branch --<tab>
--abbrev=     --color       --contains    --merged      --no-abbrev   --no-color    --no-merged   --no-track    --track       --verbose
```



