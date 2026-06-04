
# opencode.ps1 — AI-powered commit message helpers
#
# Provides functions that pipe git diff/status information into AI tools
# (opencode, llm) to generate commit messages automatically.
#
# Functions:
#
# occ   — Generates a commit message using `opencode run --agent plan`.
#         Pipes the output of `git wt step commit --show-prompt` into opencode.
#         Command: git wt step commit --show-prompt | opencode run --agent plan
#
# llmc  — Generates a commit message using the `llm` CLI.
#         Pipes the output of `git wt step commit --show-prompt` into llm.
#         Command: git wt step commit --show-prompt | llm
#
# ocm   — Generates a commit message via opencode and commits it in one step.
#         Pipes `git wt step commit --show-prompt` through opencode, then
#         feeds the result into `git commit --file -`.
#         Command: git wt step commit --show-prompt | opencode run --agent plan | git commit --file -
#
# cm    — Builds a detailed prompt with git diff, diffstat, status, untracked
#         files, current branch, and recent commits. Outputs the raw prompt
#         text to stdout for further piping. Does NOT call any AI tool itself.
#         Collected data:
#           - git diff (staged changes)
#           - git ls-files --others --exclude-standard piped to git diff --no-index (untracked)
#           - git diff --stat
#           - git status --porcelain
#           - git log -n 5 (recent commits)
#           - git branch --show-current
#
# cmo   — Generates a commit message by piping the output of `cm` into opencode.
#         Command: cm | opencode run --agent plan
#
# cmm   — Quick-and-simple commit message via opencode, without detailed diff.
#         Sends a plain-text prompt to opencode.
#
#             Write a commit message for the git staged or unstanged changes.
#             Concise commit message with small commit body describing the most important changes.
#
#         Command: echo $prompt | opencode run --agent plan
#
# cmms  — Quick-and-simple commit message via opencode, without detailed diff.
#         Sends a plain-text prompt to opencode.
#
#             Write a commit message for the git staged changes.
#             Concise commit message with small commit body describing the most important changes.
#
#         Command: echo $prompt | opencode run --agent plan

function occ {
  Write-Error "Running: git wt step commit --show-prompt | opencode run --agent plan"
  git wt step commit --show-prompt | opencode run --agent plan
}

function llmc {
  Write-Error "Running: git wt step commit --show-prompt | llm"
  git wt step commit --show-prompt | llm
}

function ocm {
  Write-Error "Running: git wt step commit --show-prompt | opencode run --agent plan | git commit --file -"
  git wt step commit --show-prompt | opencode run --agent plan | git commit --file -
}

function cm {
  $diff = git diff | Out-String
  $diffuntracked = bash -c "git ls-files --others --exclude-standard -z | xargs -0 -r -n1 git diff --no-index /dev/null --" | Out-String
  $diffstat = git diff --stat | Out-String
  $status = git status --porcelain | Out-String
  $commits = git log -n 5 --pretty=format:"- %s" | Out-String
  $branch = git branch --show-current | Out-String

  $text = @"
Write a commit message for the staged changes below.

## Format

- Subject line under 50 chars
- For impactful changes, add a blank line then a body paragraph explaining the change
- Output only the commit message (and body separated by a new line when there is a body), no quotes or code blocks

## Style

- Imperative mood: "Add feature" not "Added feature"
- Match recent commit style (conventional commits if used)
- Describe the change, not the intent or benefit

## Diffstat

git diff --stat

``````diff
$diffstat
``````

git status --porcelain

``````diff
$status
``````

## Diff

git diff

``````diff
$diff
``````

git ls-files --others --exclude-standard | git diff

``````diff
$diffuntracked
``````

## Context

Branch: $branch

### Recent_commits

- refactor: unify render parameters into FVectorWidgetsSkiaRenderParams struct
- refactor: move text rendering to SVG renderer with callback pattern
- refactor: document SVG text fragments and samples
- fix: use correct font manager for CPU renderer text rendering
- feat: support styles and presentation attributes in SVG text widgets
"@

    echo $text
}

function cmo {
  Write-Error "Running: cm | opencode run --agent plan"
  cm | opencode run --agent plan
}

function cmm-run {
  $prompt = "Write a commit message for the git staged or unstanged changes. Concise commit message with small commit body describing the most important changes."

  Write-Error 'Running: opencode run --agent plan --prompt "$prompt"'
  opencode run --agent plan "$prompt"
}

function cmms-run {
  $prompt = "Write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  Write-Error 'Running: opencode run --agent plan --prompt "$prompt"'
  opencode run --agent plan "$prompt"
}

function cmm {
  $prompt = "Write a commit message for the git staged or unstanged changes. Concise commit message with small commit body describing the most important changes."

  Write-Error 'Running: opencode run --agent plan --prompt "$prompt"'
  opencode --agent plan --prompt "$prompt"
}

function cmms {
  $prompt = "Write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  Write-Error 'Running: opencode run --agent plan --prompt "$prompt"'
  opencode --agent plan --prompt "$prompt"
}

function oc-help {
  bat "$PSScriptRoot\opencode.ps1" -r :50
}
