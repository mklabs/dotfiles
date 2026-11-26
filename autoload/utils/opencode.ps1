
# opencode.ps1 — AI-powered commit message helpers
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
# oc-help — Print lines 1–23 of this file via bat.
#
# `opencode mini --prompt` writes progress output to stderr, so only the final
# message reaches stdout.

function cmm {
  $prompt = "Write a commit message for the git staged changes (or unstaged if no staged changes). Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  Write-Error 'Running: opencode mini --agent plan "$prompt"'
  opencode mini --agent plan --prompt "$prompt"
}

function cmmr {
  $prompt = "/review Review and write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  Write-Error 'Running: opencode mini --agent plan "$prompt"'
  opencode mini --agent plan --prompt "$prompt"
}

function cmtui {
  $prompt = "Suggest a commit message for the git staged changes (or unstaged if no staged changes). Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  Write-Error 'Running: opencode --prompt "$prompt"'
  opencode --prompt "$prompt"
}

function cmtuir {
  $prompt = "/review Review and suggest a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes. No line break folding in bullet lists or body description."

  Write-Error 'Running: opencode --prompt "$prompt"'
  opencode --prompt "$prompt"
}

function oc-help {
  bat "$PSScriptRoot\opencode.ps1" -r :23
}
