workflow "Master Publish" {
  on = "push"
  resolves = [
    "Finish",
  ]
}

action "isMaster" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Clean Public" {
  uses = "actions/bin/sh@master"
  needs = ["isMaster"]
  args = ["rm -rf public"]
}

action "Create Public" {
  uses = "actions/bin/sh@master"
  args = ["mkdir public"]
  needs = ["Clean Public"]
}

action "Clean Worktree" {
  uses = "jukefr/actions/git@master"
  needs = ["Create Public"]
  args = ["worktree prune"]
}

action "Clean Worktree More" {
  uses = "actions/bin/sh@master"
  needs = ["Clean Worktree"]
  args = ["rm -rf .git/worktrees/public/"]
}

action "Checkout GH-PAGES" {
  uses = "jukefr/actions/git@master"
  needs = ["Clean Worktree More"]
  args = ["worktree add -B gh-pages public origin/gh-pages"]
}

action "Clean Dist" {
  uses = "actions/bin/sh@master"
  needs = ["Checkout GH-PAGES"]
  args = ["rm -rf public/*"]
}

action "Download" {
  uses = "actions/bin/sh@master"
  needs = ["Clean Dist"]
  args = ["wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.53/hugo_extended_0.53_Linux-64bit.deb"]
}

action "Install Hugo" {
  uses = "actions/bin/sh@master"
  needs = ["Download"]
  args = ["dpkg -i /tmp/hugo.deb"]
}

action "Build Public" {
  uses = "actions/bin/sh@master"
  needs = ["Install Hugo"]
  args = ["hugo"]
}

action "Add CNAME" {
  uses = "actions/bin/sh@master"
  needs = ["Build Public"]
  args = ["echo nodend.com >> CNAME"]
}

action "Commit" {
  uses = "jukefr/actions/git@master"
  needs = ["Add CNAME"]
  args = ["cd public && git add --all && git commit -m github-actions-build"]
}

action "Finish" {
  uses = "jukefr/actions/git@master"
  needs = ["Commit"]
  args = ["push origin gh-pages"]
}
