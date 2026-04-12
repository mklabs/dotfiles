
# Few shorthand helpers to generate commit messages

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
