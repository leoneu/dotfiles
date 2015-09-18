#!zsh -x

cd ~/dotfiles

user_name=$(git config --global --get user.name)
[[ ! -n $user_name ]] && git config --global user.name "Leo Neumeyer"

user_email=$(git config --global --get user.email)
[[ ! -n $user_email ]] && git config --global user.email "leoneu@apache.org"


git config --global core.excludesfile "~/.gitignore_global"
git config --global core.editor "emacs -nw"

git config --global alias.co checkout
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.ru remote update
git config --global alias.br branch
git config --global alias.cam "commit -a -m"
git config --global alias.br branch
git config --global alias.staged "diff --cached"
git config --global alias.unstaged diff
git config --global alias.both "diff HEAD"
git config --global alias.oneline "log --oneline"
git config --global alias.amend "commit --amend"
git config --global alias.undo "reset --hard HEAD^"
git config --global alias.tree "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.myhist "!git log --author=\"$(git config user.name)\" --format=%H |xargs git show --name-only --format=-------------%n%Cred%s%Creset%n%Cblue%h%Creset"
git config --global push.default simple
git config --global godiff.external "go-diff"
git config --global branch.autosetupmerge true
git config --global log.decorate short
git config --global color.ui auto
git config --global pager.status true
git config --global pager.show-branch true
git config --global format.numbered auto
git config --global credential.helper store
