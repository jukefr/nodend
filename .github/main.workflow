workflow "Master Publish" {
  on = "push"
  resolves = ["Git Push"]
}

action "isMaster" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Remove Public" {
  uses = "actions/bin/sh@master"
  needs = ["isMaster"]
  args = ["rm -rf public"]
}

action "Create Public" {
  uses = "actions/bin/sh@master"
  args = ["mkdir public"]
  needs = ["Remove Public"]
}

action "Clean Worktree" {
  uses = "jukefr/actions/git@master"
  needs = ["Create Public"]
  args = ["worktree prune"]
}

action "Clean Worktree Public" {
  uses = "actions/bin/sh@master"
  needs = ["Clean Worktree"]
  args = ["rm -rf .git/worktrees/public/"]
}

action "Checkout gh-pages" {
  uses = "jukefr/actions/git@master"
  args = ["worktree add -B gh-pages public origin/gh-pages"]
  needs = ["Clean Worktree Public"]
}

action "Clean Public (gh-pages)" {
  uses = "actions/bin/sh@master"
  args = ["rm -rf public/*"]
  needs = ["Checkout gh-pages"]
}

action "Build" {
  uses = "jukefr/actions/hugo@master"
  needs = ["Clean Public (gh-pages)"]
}

action "Add CNAME" {
  uses = "actions/bin/sh@master"
  args = ["echo nodend.com >> public/CNAME"]
  needs = ["Build"]
}

action "Git Add" {
  uses = "jukefr/actions/git@master"
  needs = ["Add CNAME"]
  args = ["-C public add --all"]
}

action "Git Commit" {
  uses = "jukefr/actions/git@master"
  needs = ["Git Add"]
  args = ["-C public commit -m github-actions-build"]
}

action "Git Push" {
  uses = "jukefr/actions/git@master"
  args = ["push origin gh-pages"]
  needs = ["Git Commit"]
  secrets = ["GIT_TOKEN", "GIT_USER"]
}
