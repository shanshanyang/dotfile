# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# Daily use

# View the current working tree status using the short format
alias gs='git status -sb'
alias ga='git add -A && gs'
alias gac='git add -A && git commit -m'
# git-commit-reuse commit message + [commit sha]
alias gcc='git commit -C'
# git-commit-a Commit all changes
alias gca='git commit -a'
# git-checkout
alias gch='git checkout'
# git-commit-amend Amend the currently staged files to the latest commit
alias gcm='git commit --amend -C HEAD'
# git-log-short View abbreviated SHA, description, and history graph of the latest 20 commits
alias gls='git log --pretty=oneline -n 20 --graph --abbrev-commit'
# git-log-long
alias gll="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
# git-remove-cached
alias gmc='git rm --cached'
# git-push-head
alias gph='git push origin HEAD'
# git-pull
alias gl='git pull'
alias glp='git pull --prune'


# Git Tags

# git-tag-list Tags
alias gtl='git tag -l'
# git-push-tag
alias gpt='git push --tags origin HEAD'

# Submodules

# git-clone-recursive Clone a repository including all submodules
alias gcr='git clone --recursive'
# Pull in remote changes for the current repository and all its submodules
alias gp=!"git pull; git submodule foreach git pull origin master"

# The rest of my fun git aliases
alias gpush-undo='git push -f origin HEAD^:master'
alias gd='git diff'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gundo='git reset --soft HEAD^'

# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'


# Show the diff between the latest commit and the current state
alias d=!"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat"

# `git di $number` shows the diff between the state `$number` revisions ago and the current state
alias di=!"d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d"


# Switch to a branch, creating it if necessary
alias go="!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f"

# Show verbose output about tags, branches or remotes
alias branches='git branch -a'
alias remotes='git remote -v'


# Credit an author on the latest commit
alias credit="!f() { git commit --amend --author \"$1 <$2>\" -C HEAD; }; f"

# Interactive rebase with the given number of latest commits
alias reb="!r() { git rebase -i HEAD~$1; }; r"

# Find branches containing commit
alias fb="!f() { git branch -a --contains $1; }; f"

# Find tags containing commit
alias ft="!f() { git describe --always --contains $1; }; f"

# Find commits by source code
alias fc="!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f"

# Find commits by commit message
alias fm="!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f"

# Remove branches that have already been merged with master
# a.k.a. ‘delete merged’
alias dm="!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"

# List contributors with number of commits
alias contributors=shortlog --summary --numbered

# Merge GitHub pull request on top of the `master` branch
alias mpr="!f() { \
  if [ $(printf \"%s\" \"$1\" | grep '^[0-9]\\+$' > /dev/null; printf $?) -eq 0 ]; then \
    git fetch origin refs/pull/$1/head:pr/$1 && \
    git rebase master pr/$1 && \
    git checkout master && \
    git merge pr/$1 && \
    git branch -D pr/$1 && \
    git commit --amend -m \"$(git log -1 --pretty=%B)\n\nCloses #$1.\"; \
  fi \
}; f"
