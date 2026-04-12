# PowerShell Profile

Personal PowerShell configuration with autoload scripts, aliases, completions, and utility functions.

## Quick Start

1. **Clone repository**: `git clone -b windows https://github.com/mklabs/dotfiles.git ~/Documents/PowerShell`
2. **Debug loading**: Set `$env:DEBUG_PWSH=1` to see load times for each script (optional)

## Structure

Scripts are automatically loaded via `Microsoft.PowerShell_profile.ps1`. To add new scripts, simply create a new `.ps1` file in the appropriate directory based on the desired loading time.

| Directory | Purpose |
|-----------|---------|
| `autoload/init/` | Initialization (prompt, modules, tools) |
| `autoload/completions/` | Tab completion definitions |
| `autoload/utils/` | Utility functions and aliases |
| `autoload/after/` | Post-initialization (aliases, settings) |

Workflow:

- Edit scripts in appropriate `autoload/` subdirectory
- Changes take effect on next shell startup or after sourcing

## Key Commands

| Command | Description |
|---------|-------------|
| `l`, `ll`, `lll`, `tree` | eza-based listings |
| `tapo [light\|tv] <cmd>` | Control Tapo/Kasa devices |
| `bulb <cmd>` | Light shortcuts (toggle, on, off, dimm, brighten) |
| `nvim` | Neovim editor |
| `lg` | lazygit |
| `z <dir>` | zoxide smart cd |
| `occ`, `ocm`, `cmo` | Commit message helpers via opencode |

## Dependencies

External tools required:
- **Starship** - Shell prompt
- **PSFzf** - Fuzzy finder (`Ctrl+f`, `Ctrl+r`)
- **Terminal-Icons** - File icons
- **posh-git** - Git status
- **BurntToast** - Toast notifications
- **eza** - Modern `ls` replacement
- **zoxide** - Smart directory jumping
- **kasa** - Tapo device control

## Debugging

Set debug mode for load timing:

```powershell
$env:DEBUG_PWSH=1
```

## Tapo Notes

- Set `KASA_USERNAME` and `KASA_PASSWORD` environment variables for Tapo/Kasa device control
- Add to your profile: `$env:KASA_USERNAME="your-email"` and `$env:KASA_PASSWORD="your-password"`

