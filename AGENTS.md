# AGENTS.md - zsh Profile Repository Guidelines

## Overview
This repository contains a zsh configuration for macOS with autoload scripts, aliases, completions, and utility functions. It is not a traditional software project with build/test commands.

## Structure
```
autoload/
├── init/       # Initialization scripts (prompt, modules, tools)
├── completions/ # Tab completion definitions for various tools
├── utils/       # Utility functions and aliases
└── after/       # Post-initialization configuration (aliases, settings)

.zshrc          # Main profile entry point
README.md       # Documentation and setup instructions
```

## Loading Scripts
Scripts are automatically loaded via `.zshrc`:
- All `.zsh` files in `autoload/init/`
- All `.zsh` files in `autoload/completions/`
- All `.zsh` files in `autoload/utils/`
- All `.zsh` files in `autoload/after/`

Debug mode: Set `$DEBUG_ZSH=1` to see load times for each script.

## Code Style Guidelines

### Function Naming
- Use lowercase with hyphens or camelCase (e.g., `lls`, `htmlqq`, `bulb`)
- Utility functions should be concise and descriptive
- Follow existing conventions in the repository

### Script Structure
- Start with a comment header describing the tool/purpose
- Include upstream URLs in comments where applicable (e.g., https://starship.rs)
- Keep scripts focused and single-purpose
- Use `"$@"` for forwarding arguments to underlying commands

### Error Handling
- Use `echo` for error messages with return codes
- Return early with `return` after errors
- Check conditions with `[ ]` or `[[ ]]` before executing commands

### Variables
- Use `$VAR` or `${VAR}` for environment variables
- Use `"$@"` for argument array
- Use `$(brew --prefix)` for Homebrew paths
- Declare parameters explicitly when type matters

### Formatting
- 2-space indentation (zsh convention)
- Empty lines between logical sections
- Comments on separate lines, not trailing
- Quoted strings consistently (double quotes preferred for interpolation)

### Modules and Imports
- Use `autoload -Uz compinit` and `compinit` for completions
- Check Homebrew paths before sourcing
- Use conditional checks `[ -f path ] && source path` for optional dependencies

## Dependencies
This profile uses external tools/modules:
- **Starship** - Cross-shell prompt
- **fzf** - Fuzzy finder integration (`Ctrl+f`, `Ctrl+r`)
- **zsh-autosuggestions** - Command suggestions
- **zsh-syntax-highlighting** - Syntax highlighting
- **eza** (external binary) - Modern `ls` replacement
- **timer** - CLI timer for Pomodoro
- **terminal-notifier** - macOS notifications
- **zoxide** - Smart directory jumping

## Testing
Manual testing approach:
1. Start a new zsh session to load the profile
2. Source individual scripts with `. script.zsh` for debugging
3. Use `DEBUG_ZSH=1` to measure load performance
4. Test functions interactively in the shell

## Common Patterns

### Function forwarding
```zsh
function mycmd {
  & $tool "$@"
}
```

### Path validation
```zsh
if [ -f "$path" ]; then
  source "$path"
else
  echo "Not found: $path"
  return 1
fi
```

### Parameter handling
```zsh
function cmd {
  local opt="${1:-default}"
  # ... logic
}
```

## Git Workflow
- Commit changes to specific autoload subdirectories
- Use descriptive commit messages explaining the change
- No PRs typically needed for personal profile updates

## macOS-Specific Notes

### Clipboard
- Use `pbcopy` to copy to clipboard
- Use `pbpaste` to paste from clipboard

### Notifications
- Use `terminal-notifier` for GUI notifications
- Use `osascript` for AppleScript integration

### Homebrew
- Use `brew --prefix` to get installation paths
- Check for optional dependencies before sourcing

### Path separators
- Use `/` for paths (not `\`)
- Use `$HOME` for home directory
- Use `$PWD` for current working directory
