# zsh Profile

Personal zsh configuration for macOS with Starship prompt, fzf, and utility functions.

## Setup

1. Install dependencies via Homebrew:
   ```
   brew install starship fzf zsh-autosuggestions zsh-syntax-highlighting eza yazi caarlos0/tap/timer terminal-notifier zoxide
   ```

2. Clone to `~/.dotfiles` and symlink:
   ```
   git clone -b osx https://github.com/mklabs/dotfiles.git ~/.dotfiles
   ln -s ~/.dotfiles/.zshrc ~/.zshrc
   ```

## Structure

```
autoload/
├── init/        # Core init: Starship, fzf, yazi
├── completions/ # Tab completion definitions
├── utils/       # Utility functions (htmlq, pomodoro, nvim)
└── after/       # Post-init: zoxide, aliases
```

Scripts load automatically from `.zshrc`.

## Debugging

```zsh
DEBUG_ZSH=1  # See load times for each script
. ~/.zshrc   # Source to reload
```

## Key Tools

- **Starship** - Cross-shell prompt
- **fzf** - `Ctrl+f` (files), `Ctrl+r` (history)
- **yazi** - `y` command for file manager with cwd sync
- **eza** - `ls` replacement
- **timer** - Pomodoro timer with notifications
- **zoxide** - `z` for smart directory jumping

## macOS-Specific

- Clipboard: `pbcopy`, `pbpaste`
- Notifications: `terminal-notifier`
