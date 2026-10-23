# AGENTS.md

## What this repo is

Personal PowerShell 7 profile. The repo is cloned **directly into `~/Documents/PowerShell`** (the live PowerShell user directory), on branch `windows` of `mklabs/dotfiles`. Consequences:

- `Modules/` is the real user module path — posh-git, PSFzf, Terminal-Icons, BurntToast, DockerCompletion, etc. are **vendored here**, which is why `Import-Module Terminal-Icons` works with no path. Don't tell the user to `Install-Module` these; update the vendored copy.
- `Scripts/` is the live user scripts path (currently only `InstalledScriptInfos/`).
- Changes to any file take effect in the user's actual shell on next startup — test carefully.

## How loading works

`Microsoft.PowerShell_profile.ps1` dot-sources every `.ps1` in these directories, **in this order**:

1. `autoload/init/` — modules, prompt (starship), PSReadLine, tool init
2. `autoload/completions/`
3. `autoload/utils/` — functions
4. `autoload/after/` — aliases and overrides

Order matters: `after/alias.ps1` does `Set-Alias ls lls` where `lls` is defined in `utils/eza.ps1`. Put new scripts in the directory matching when they must run.

## Testing / debugging

No build, lint, or test framework. Verify changes by:

- Starting a new `pwsh` session, or dot-sourcing the single file: `. .\autoload\utils\foo.ps1`
- `$env:DEBUG_PWSH=1` before startup prints per-script load timings

## Conventions

- 2-space indent; comment header per file with upstream URL (e.g. `# https://starship.rs`); wrapper functions forward with `@args`; validate then `return` early.
- Function names are lowercase single words (`lls`, `quake`, `tapo`) or lowercase-hyphenated (`oc-help`, `Invoke-Starship-PreCommand` for starship hooks).
- **`Write-Error` is used intentionally for status/info output** in `autoload/utils/opencode.ps1` — it keeps stdout clean because these helpers pipe into `git commit --file -`. Do not "fix" these to `Write-Host`.
- `autoload/utils/opencode-history.ps1` provides `och` (fuzzy-search opencode prompt history) and binds `Ctrl+O` via `Set-PSReadLineKeyHandler` — history lives in `~/.local/state/opencode/prompt-history.jsonl`.
- `COMMANDS.md` at the repo root is the single source of truth for available commands. **Any change that adds, removes, or alters a function, alias, or key binding must update `COMMANDS.md` in the same change.** `dotfiles-command` (defined in `autoload/utils/dotfiles-help.ps1`) renders it as runtime help via `glow`; `dotfiles-help` parses the same file to print a compact command list (`-c` groups by category).
- Keep the header comment block at the top of `autoload/utils/opencode.ps1` accurate: `oc-help` displays lines 1–50 of that file as runtime help via `bat`.
- `autoload/utils/bat.ps1` removes the built-in `cat` alias before defining a `cat` function — follow that pattern when overriding an existing alias.

## Interactive shell quirks (relevant when verifying)

The loaded shell is heavily remapped: `cd` → zoxide's `z`, `ls` → eza-based `lls`, `cat` → `bat -pp`, `grep` → `findstr`, `open` → `start`. Don't rely on stock cmdlet behavior in an interactive session.

## Dependencies

- PowerShell modules: vendored in `Modules/` (see above).
- External binaries assumed on PATH: starship, eza, zoxide, bat, fzf, lazygit, nvim, `kasa` (python-tapo).
- `tapo` requires `$env:KASA_USERNAME` / `$env:KASA_PASSWORD`.

## Commits

Conventional-commit style, scope = autoload area or script name, e.g. `utils(ffmpeg): add ffc helper`, `completions: add just tab completion`, `opencode: cmmr function`. No PRs — commit directly to `windows`.
