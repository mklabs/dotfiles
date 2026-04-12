# AGENTS.md - PowerShell Profile Repository Guidelines

## Overview
This repository contains a PowerShell profile configuration with autoload scripts, aliases, completions, and utility functions. It is not a traditional software project with build/test commands.

## Structure
```
autoload/
├── init/       # Initialization scripts (prompt, modules, tools)
├── completions/ # Tab completion definitions for various tools
├── utils/       # Utility functions and aliases
└── after/       # Post-initialization configuration (aliases, settings)

Microsoft.PowerShell_profile.ps1  # Main profile entry point
powershell.config.json           # PowerShell execution policy config
```

## Loading Scripts
Scripts are automatically loaded via `Microsoft.PowerShell_profile.ps1`:
- All `.ps1` files in `autoload/init/`
- All `.ps1` files in `autoload/completions/`
- All `.ps1` files in `autoload/utils/`
- All `.ps1` files in `autoload/after/`

Debug mode: Set `$env:DEBUG_PWSH=1` to see load times for each script.

## Code Style Guidelines

### Function Naming
- Use lowercase with hyphens or camelCase (e.g., `bbtop`, `tapo`, `Invoke-Starship`)
- Utility functions should be concise and descriptive
- Follow existing conventions in the repository

### Script Structure
- Start with a comment header describing the tool/purpose
- Include upstream URLs in comments where applicable (e.g., https://starship.rs)
- Keep scripts focused and single-purpose
- Use `@args` for forwarding arguments to underlying commands

### Error Handling
- Use `Write-Error` for error messages
- Return early with `return` after errors
- Check path existence with `Test-Path` before using paths
- Validate parameters before execution

### Variables
- Use `$env:` for environment variables
- Use `$args` for automatic argument array
- Use `$PSScriptRoot` for script-relative paths
- Declare parameters explicitly with `[string]`, `[int]`, etc. when type matters

### Formatting
- 2-space indentation (PowerShell convention)
- Empty lines between logical sections
- Comments on separate lines, not trailing
- Quoted strings consistently (single quotes preferred unless interpolation needed)

### Modules and Imports
- Import modules at the top of init scripts
- Check module availability before use when appropriate
- Use `Import-Module` for PowerShell modules
- Dot-source utility scripts with `. $Path` pattern

## Dependencies
This profile uses external tools/modules:
- **Starship** - Cross-shell prompt
- **PSFzf** - Fuzzy finder integration
- **Terminal-Icons** - File icons in listings
- **posh-git** - Git status in prompt/completions
- **BurntToast** - Windows toast notifications
- **eza** (external binary) - Modern `ls` replacement

## Testing
No formal test framework exists. Manual testing approach:
1. Start a new PowerShell session to load the profile
2. Source individual scripts with `. script.ps1` for debugging
3. Use `$env:DEBUG_PWSH=1` to measure load performance
4. Test functions interactively in the shell

## Common Patterns

### Function forwarding
```powershell
function mycmd {
    & $tool @args
}
```

### Path validation
```powershell
if (Test-Path $path) {
    & $path @args
} else {
    Write-Error "Not found: $path"
    return
}
```

### Parameter handling
```powershell
function cmd {
  param ([string]$Opt = "")
  # ... logic
}
```

## Git Workflow
- Commit changes to specific autoload subdirectories
- Use descriptive commit messages explaining the change
- No PRs typically needed for personal profile updates
