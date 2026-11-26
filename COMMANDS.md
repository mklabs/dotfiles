# Commands

Everything this PowerShell profile adds: functions, aliases, key bindings, and tab completions. Rendered at the terminal with `dotfiles-command` (via `glow`); `dotfiles-help` prints a compact list of commands.

## Help

| Command | Description | Source |
|---------|-------------|--------|
| `dotfiles-help [-c]` | Compact list of all commands parsed from this file (flat by default, grouped by category with `-c`) | `utils/dotfiles-help.ps1` |
| `dotfiles-command` | Render the full `COMMANDS.md` reference via `glow` | `utils/dotfiles-help.ps1` |

## File system & navigation

| Command | Description | Source |
|---------|-------------|--------|
| `cd <dir>` | Smart directory jump via zoxide (`z`) | `after/zoxide.ps1` |
| `ls` | eza listing, `-a --color=always --git` (alias of `lls`) | `after/alias.ps1`, `utils/eza.ps1` |
| `ll` | eza long listing with icons (`--long --git --icons=always`) | `utils/eza.ps1` |
| `lll` | eza long listing, no icons | `utils/eza.ps1` |
| `tree` | eza tree view, `-T --level=2` | `utils/eza.ps1` |
| `y` | Launch yazi file manager; `cd` to its cwd on exit | `init/yazi.ps1` |
| `cat <file>` | Read files via `bat -pp` | `utils/bat.ps1` |
| `touch <path>` | Create empty file, or bump `LastWriteTime` if it exists | `utils/touch.ps1` |
| `pwdd` | Print current directory as a plain path (unix-style, no table) | `utils/pwd.ps1` |
| `pwdc` | Copy current directory path to the clipboard | `utils/pwd.ps1` |
| `envpath` | Split `PATH` and fuzzy-filter the entries with fzf | `utils/envpath.ps1` |
| `which <cmd>` | Print the resolved path of a command | `utils/which.ps1` |
| `dd` | Disk usage via `pdu --top-down -d 2` (binary format) | `utils/pdu.ps1` |
| `la`, `ls`, `cp`, `rm`, … | GNU coreutils commands, rewritten to `coreutils\cmd\*.cmd` at the readline level | `utils/core-utils.ps1` |

## Git & commit helpers

| Command | Description | Source |
|---------|-------------|--------|
| `g` | `git` | `after/alias.ps1` |
| `lg` | `lazygit` | `after/alias.ps1` |
| `occ` | Commit message via `git wt step commit --show-prompt \| opencode run --agent plan` | `utils/opencode.ps1` |
| `llmc` | Commit message via `git wt step commit --show-prompt \| llm` | `utils/opencode.ps1` |
| `ocm` | Generate commit message with opencode **and** commit it (`git commit --file -`) | `utils/opencode.ps1` |
| `cm` | Build a detailed diff/diffstat/status prompt to stdout (no AI call; pipe it yourself) | `utils/opencode.ps1` |
| `cmo` | `cm \| opencode run --agent plan` | `utils/opencode.ps1` |
| `cmm` | Quick commit message (staged or unstaged changes) via `opencode run --agent plan` | `utils/opencode.ps1` |
| `cmms` | Quick commit message (staged changes only) via `opencode run --agent plan` | `utils/opencode.ps1` |
| `cmmr` | `/review`-based commit message for staged changes via `opencode run --agent plan` | `utils/opencode.ps1` |
| `oc-help` | Show the `opencode.ps1` header (lines 1–57) via `bat` | `utils/opencode.ps1` |
| `och` | Fuzzy-search opencode prompt history with fzf (`-Copy` copies, `-Query` seeds, `-NoShell` hides shell entries) | `utils/opencode-history.ps1` |

## Editors

| Command | Description | Source |
|---------|-------------|--------|
| `vim` | `nvim` | `after/alias.ps1` |
| `nvc` | `nvim` with `NVIM_APPNAME=nvim.custom` | `utils/nvim.ps1` |
| `nvk` | `nvim` with `NVIM_APPNAME=nvim.kickstart` | `utils/nvim.ps1` |
| `nvl` | `nvim` with `NVIM_APPNAME=nvim.lazy` | `utils/nvim.ps1` |
| `nva` | `nvim` with `NVIM_APPNAME=nvim.advent` | `utils/nvim.ps1` |
| `nvmk` | `nvim` with `NVIM_APPNAME=nvim.mklabs-advent` | `utils/nvim.ps1` |

## Windows Terminal

| Command | Description | Source |
|---------|-------------|--------|
| `quake [cmd]` | Open / run a command in the `_quake` window (`wt -w _quake`) | `utils/windows-terminal.ps1` |
| `q` | `quake` | `after/alias.ps1` |
| `qtop` | `btop` in the quake window | `utils/windows-terminal.ps1` |
| `floatingterm [cmd]` | Open / run a command in the floating window (`wt -w floating -f`) | `utils/windows-terminal.ps1` |
| `f` | `floatingterm` | `after/alias.ps1` |
| `ftop` | `btop` in the floating window | `utils/windows-terminal.ps1` |

## Tapo / Kasa devices

Requires `$env:KASA_USERNAME` and `$env:KASA_PASSWORD`.

| Command | Description | Source |
|---------|-------------|--------|
| `tapo <light\|tv> <cmd>` | Run a kasa command against the light (192.168.0.133) or TV (192.168.0.153) | `utils/tapo.ps1` |
| `tapojson <light\|tv> <cmd>` | Same, with `--json` output | `utils/tapo.ps1` |
| `bulb <cmd>` | Light shortcuts: `state`, `info`, `on`, `off`, `dimm`/`down`, `brighten`/`up`; no arg toggles | `utils/tapo.ps1` |

## Processes & ports

| Command | Description | Source |
|---------|-------------|--------|
| `listening [-All]` | List processes with listening ports (loopback only by default, all with `-All`) | `utils/listening.ps1` |
| `pk [-All]` | fzf-select a listening process and kill it after a `Y/n` confirm | `utils/listening.ps1` |

## Media, web & misc

| Command | Description | Source |
|---------|-------------|--------|
| `ffc [--name N] [--output P] [--list] [--fuzzy] [--audio] [--max-size MB] [--crf N]` | Convert the latest OBS MKV (`W:\Media\OBS\<yyyy-MM>`) to a share-friendly MP4: HDR->SDR tone-map, 8-bit H.264 High (never Hi10P), `+faststart`, two-pass sized to `--max-size` (default 10 MB); audio stripped unless `--audio` | `utils/ffmpeg.ps1` |
| `htmlqq <url> <selector> [theme]` | `curl` + `htmlq` + `bat` (Nord theme) for a selector | `utils/htmlq.ps1` |
| `htmlqqt <url> <selector>` | Same, but pick the bat theme via fzf | `utils/htmlq.ps1` |
| `work [minutes=30]` | Pomodoro work timer, toast notification when done | `utils/pomodoro.ps1` |
| `rest [minutes=10]` | Pomodoro break timer, toast notification when done | `utils/pomodoro.ps1` |
| `llama-qwen-test` | Start `llama-server` serving `unsloth/Qwen3.6-35B-A3B-GGUF` on port 8033 | `utils/llama.cpp.ps1` |
| `ocp <dest>` | fzf-select files from the Obsidian vault and copy them to `<dest>` | `utils/obsidian.ps1` |

## Misc aliases

| Alias | Target |
|-------|--------|
| `vim` | `nvim` |
| `g` | `git` |
| `grep` | `findstr` |
| `open` | `start` |
| `q` | `quake` |
| `f` | `floatingterm` |
| `ls` | `lls` |
| `lg` | `lazygit` |
| `oc` | `opencode` |
| `cd` | `z` (zoxide) |

## Key bindings

| Binding | Action | Source |
|---------|--------|--------|
| `Ctrl+d` | Delete char, or exit the session at an empty prompt | `init/init.ps1` |
| `Ctrl+f` | PSFzf provider | `init/prompt.ps1` |
| `Ctrl+r` | PSFzf reverse history | `init/prompt.ps1` |
| `Ctrl+t` | tv smart autocomplete for the current command | `utils/tv.ps1` |
| `Ctrl+o` | Fuzzy-search opencode prompt history (replaces the buffer) | `utils/opencode-history.ps1` |

## Tab completions

| Command | Source |
|---------|--------|
| `deno` | `completions/deno.completions.ps1` |
| `docker` | `completions/docker.completions.ps1` (`DockerCompletion`) |
| `git` | `completions/git.completions.ps1` (`posh-git`) |
| `gh` | `completions/github.completions.ps1` |
| `just` | `completions/just.ps1` |
| `winget` | `completions/winget.completions.ps1` |
| `tv` | `utils/tv.ps1` (native argument completer) |
| `choco` | `init/chocolatey.ps1` |

## Prompt & shell features

- **Starship** prompt with Windows Terminal same-directory integration (`Invoke-Starship-PreCommand`) — `init/prompt.ps1`
- **Terminal-Icons** file/type icons — `init/prompt.ps1`
- **PSReadLine** history prediction (ListView) — `init/prompt.ps1`