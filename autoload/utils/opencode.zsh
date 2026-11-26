# opencode.zsh — AI-powered commit message helpers
#
# Thin wrappers around the `opencode` CLI: ask an agent to write a commit
# message for the current git changes.
#
# Functions:
#
# cmm    — Commit message for staged changes (unstaged if nothing is staged),
#          generated headlessly via `opencode mini --agent plan`.
#
# cmmr   — Same as cmm, but prefixed with /review so the agent reviews the
#          staged changes first.
#
# cmtui  — Prefill the interactive TUI with a commit-message prompt
#          (`opencode --prompt`); nothing is committed for you.
#
# cmtuir — Same as cmtui, but prefixed with /review.
#
# oc-help — Print lines 1–22 of this file via bat.
#
# `opencode mini --prompt` writes progress output to stderr, so only the final
# message reaches stdout.

cmm() {
  local prompt="Write a commit message for the git staged changes (or unstaged if no staged changes). Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  echo "Running: opencode mini --agent plan --prompt \"$prompt\"" >&2
  opencode mini --agent plan --prompt "$prompt"
}

cmmr() {
  local prompt="/review Review and write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  echo "Running: opencode mini --agent plan --prompt \"$prompt\"" >&2
  opencode mini --agent plan --prompt "$prompt"
}

cmtui() {
  local prompt="Suggest a commit message for the git staged changes (or unstaged if no staged changes). Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  echo "Running: opencode --prompt \"$prompt\"" >&2
  opencode --prompt "$prompt"
}

cmtuir() {
  local prompt="/review Review and suggest a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  echo "Running: opencode --prompt \"$prompt\"" >&2
  opencode --prompt "$prompt"
}

oc-help() {
  bat "${functions_source[oc-help]}" -r :22
}
