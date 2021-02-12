BASE='/mnt/d'
# oh-my-zsh 
export ZSH=$BASE/stash/ds-base/ohmyzsh-master
ZSH_THEME="bureau"
plugins=(git python pip history extract vscode ansible battery colored-man-pages docker-compose)
source $ZSH/oh-my-zsh.sh

# HISTORY
HISTSIZE=10000
export HISTSIZE
export HISTTIMEFORMAT="%F %T "
HISTFILE=~/HISTORY/history-`date '+%Y.%m.%d_%H%M'`
export HISTFILE
export PROMPT_COMMAND="history -a"

## set python env
export PIP_REQUIRE_VIRTUALENV=true
source $BASE/var/py3/bin/activate

# scripts
alias a="$BASE/stash/ds-scripts/new-grep-cookbook.sh all"
alias hd="$BASE/stash/ds-scripts/hd.sh"
alias ng="$BASE/stash/ds-scripts/new-grep-cookbook.sh"
alias nga="$BASE/stash/ds-scripts/new-grep-cookbook.sh ansible"
alias ngall="$BASE/stash/ds-scripts/new-grep-cookbook.sh all"
alias ngb="$BASE/stash/ds-scripts/new-grep-cookbook.sh bash"
alias ngc="$BASE/stash/ds-scripts/new-grep-cookbook.sh cmd"
alias ngd="$BASE/stash/ds-scripts/new-grep-cookbook.sh dock"
alias ngh="$BASE/stash/ds-scripts/new-grep-cookbook.sh html"
alias ngi="$BASE/stash/ds-scripts/new-grep-cookbook.sh ipa"
alias ngl="$BASE/stash/ds-scripts/new-grep-cookbook.sh ldap"
alias ngo="$BASE/stash/ds-scripts/new-grep-cookbook.sh openshift"
alias ngp1="$BASE/stash/ds-scripts/new-grep-cookbook.sh powershell"
alias ngp="$BASE/stash/ds-scripts/new-grep-cookbook.sh python"
alias ngr="$BASE/stash/ds-scripts/new-grep-cookbook.sh rhel"
alias ngs="$BASE/stash/ds-scripts/new-grep-cookbook.sh sat"
alias t="echo $$BASE/var/tmp.txt"
alias tx="vim $BASE/var/tmp.txt"
alias tc="cat $BASE/var/tmp.txt"
alias tcl="> $BASE/var/tmp.txt"

# profiles 
alias b="source ~/.bash_profile"
alias bc="cat ~/.bash_profile"
alias bx="code ~/.bash_profile"

alias z=". ~/.zshrc"
alias zx="code ~/.zshrc"
alias zc="cat ~/.zshrc"
alias cds="cd /mnt/d/stash"
alias dd='D="`date +%Y-%m-%d_%H%M`";echo $D'
alias dt='date +%H:%M'
alias dw="date +%W"

# basics 
alias cl='clear'
alias cp='cp -i'
alias h="history"
alias l1="ls -1"
alias l='ls -la'
alias lm='ls -la |more'
alias lt='ls -latr'
alias h='history'
alias x=exit

# git 
alias g="git"
alias gaa="git add all "
alias gc="git commit -m"
alias gx='gaa;gc;git push'
alias gb='git branch -a' 
alias gcm="git checkout master"
alias gcf="git checkout fb"
alias gcb="git checkout -b"
alias gf="git fetch"
alias gm="git merge"
gr='git remote'
alias gp="git push"
alias glog="git log --oneline --decorate --graph" 

# docker aliases
alias d="docker"
alias dps="docker ps"

# ones to try out
alias npmhelp='firefox https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/npm'
alias caf='nohup caffeinate -disu &>/dev/null  &'

