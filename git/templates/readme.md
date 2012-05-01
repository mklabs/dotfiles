**git init templates**

* `git help init`

* http://schacon.github.com/git/git-init.html#_template_directory


When Git creates a new repository, it can use a template to populate
certain files and directories to the `$GIT_DIR` after it is created.

The template directory used is (in order):

* The argument given with the --template option.
* The contents of the `$GIT_TEMPLATE_DIR` environment variable.
* The `init.templatedir` configuration variable.
* The default template directory: `/usr/share/git-core/templates`

The default template directory includes some directory structure, some
suggested "exclude patterns", and copies of sample "hook" files. The
suggested patterns and hook files are all modifiable and extensible.

---

* default:
  * excludes commonly .gitignored files: `.DS_Store node_modules npm-debug.log`
  * pre-commit hook: Runs npm test, abort commit on test fail. If npm is
    installed locally (eg. node_modules/npm is there), npm is used
    programmatically, otherwise the global `npm` binary is used.


