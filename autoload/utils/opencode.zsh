# Commit message helpers

occ() {
  echo "Running: wt step commit --show-prompt | opencode run --agent plan"
  wt step commit --show-prompt | opencode run --agent plan
}

llmc() {
  echo "Running: wt step commit --show-prompt | llm"
  wt step commit --show-prompt | llm
}

ocm() {
  wt step commit --show-prompt | opencode run --agent plan | git commit --file -
}

cm() {
  local diff diffuntracked diffstat git_status commits branch text
  
  diff=$(git diff)
  diffuntracked=$(git ls-files --others --exclude-standard -z | xargs -0 -r -n1 git diff --no-index /dev/null --)
  diffstat=$(git diff --stat)
  git_status=$(git status --porcelain)
  commits=$(git log -n 5 --pretty=format:"- %s")
  branch=$(git branch --show-current)
  
  text="Write a commit message for the staged changes below.

## Format

- Subject line under 50 chars
- For impactful changes, add a blank line then a body paragraph explaining the change
- Output only the commit message (and body separated by a new line when there is a body), no quotes or code blocks

## Style

- Imperative mood: \"Add feature\" not \"Added feature\"
- Match recent commit style (conventional commits if used)
- Describe the change, not the intent or benefit

## Diffstat

git diff --stat

\`\`\`diff
$diffstat
\`\`\`

git status --porcelain

\`\`\`diff
$git_status
\`\`\`

## Diff

git diff

\`\`\`diff
$diff
\`\`\`

git ls-files --others --exclude-standard | git diff

\`\`\`diff
$diffuntracked
\`\`\`

## Context

Branch: $branch

### Recent_commits

$commits
"
  
  echo "$text"
}

cmo() {
  echo "Running: cm | opencode run --agent plan"
  cm | opencode run --agent plan
}

cmms() {
  local text
  text="Write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  echo 'Running: opencode run --agent plan --prompt "$text"'
  opencode --agent plan --prompt "$text"
}

cmmr() {
  local text

  text="/review Review and write a commit message for the git staged changes. Concise commit message with small commit body describing the most important changes."

  echo 'Running: opencode run --agent plan --prompt "$text"'
  opencode --agent plan --prompt "$text"
}
