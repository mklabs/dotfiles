# Prompt and shell configuration

# Starship prompt
# https://starship.rs
eval "$(starship init zsh)"

# fzf fuzzy finder
# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--height 40% --reverse --border"
[ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
