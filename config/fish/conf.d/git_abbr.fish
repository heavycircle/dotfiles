#!/usr/bin/env fish

abbr g git

abbr ga 'git add'

abbr gb 'git branch'
abbr gba 'git branch -a'
abbr gbd 'git branch -d'
abbr gbD 'git branch -D'

abbr gc 'git commit'
abbr gc! 'git commit -v --amend'
abbr gcm 'git commit -m'

abbr gco 'git checkout'
abbr gcob 'git checkot -b'

abbr gd 'git diff'
abbr gds 'git diff --staged'

abbr gf 'git fetch'
abbr gfa 'git fetch --all --prune'
abbr gfo 'git fetch origin'
abbr gfop 'git fetch origin --prune'

abbr gignore 'git update-index --assume-unchanged'
abbr gignored 'git ls-files -v | grep "^[[:lower:]]"'

abbr gl 'git log'
abbr glg 'git log --graph'
abbr glog 'git log --oneline --decorate --graph'

abbr gm 'git merge'
abbr gma 'git merge --abort'

abbr gp 'git push'
abbr gpd 'git push --dry-run'
abbr gpf! 'git push --force'
abbr gpo 'git push origin'
abbr gpt 'git push --tags'
abbr gpuo 'git push -u origin'

abbr gpl 'git pull'
abbr gplo 'git pull origin'

abbr grb 'git rebase'
abbr grbi 'git rebase -i'
abbr grbir 'git rebase -i --root'

abbr grs 'git reset'
abbr grs! 'git reset --hard'
abbr grsh 'git reset HEAD'
abbr grsh! 'git reset HEAD --hard'

abbr grm 'git rm'
abbr grmc 'git rm --cached'

abbr grst 'git restore'
abbr grstst 'git restore --staged'

abbr gs 'git status'
abbr gss 'git status -s'

abbr gst 'git stash'
abbr gsta 'git stash apply'
abbr gstp 'git stash pop'

abbr gsu 'git submodule update'

abbr gsw 'git switch'
abbr gswc 'git switch -c'

abbr gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
