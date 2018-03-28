# .bashrc

###############
# variblbe setting for promt
VER=`cat /etc/redhat-release |awk '{print $7}'`
BIT="32"
KERN=`uname -a|awk '{print $3}'| cut -f2 -d'-'|cut -f1 -d'.'`
UMG=`uname -n|cut -c12`

uname -a|grep _64 > /dev/null
if [ $? = 0 ]; then
        BIT=64
fi

###############
## check if this is a git branch
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

###############
## set the color for promt check user root (31) other (32)
if [ `whoami` == 'root' ]; then
 case ${UMG} in
   p) PS1="\n\e[0;31m\u \e[0;31m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
   v) PS1="\n\e[0;31m\u \e[0;33m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
   *) PS1="\n\e[0;31m\u \e[0;32m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
 esac
else
 case ${UMG} in
   p) PS1="\n\e[0;32m\u \e[0;31m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
   v) PS1="\n\e[0;32m\u \e[0;33m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
   *) PS1="\n\e[0;32m\u \e[0;32m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
 esac
fi
export PS1

### without git 
## set the color for promt check user root (31) other (32)
#if [ `whoami` == 'root' ]; then
# case ${UMG} in
#   p) PS1="\n\e[0;31m\u \e[0;31m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
#   v) PS1="\n\e[0;31m\u \e[0;33m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
#   *) PS1="\n\e[0;31m\u \e[0;32m\h:\[\033[30m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
# esac
#else
# case ${UMG} in
#   p) PS1="\n\e[0;32m\u \e[0;31m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
#   v) PS1="\n\e[0;32m\u \e[0;33m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
#   *) PS1="\n\e[0;32m\u \e[0;32m\h:\[\033[00m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[00m\] \nRH-$VER:$BIT:$KERN -> ";;
# esac
#fi
#export PS1
#export PS1

################
## set the history file
#unset HISTFILESIZE
#HISTSIZE=5000
#HISTFILESIZE=10000
#HISTFILE=/export/home/dstock/history-`date '+%Y.%m.%d_%H%M'`
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#HISTTIMEFORMAT="%d/%m/%y %T "

#export HISTSIZE
#export HISTFILESIZE
#export HISTTIMEFORMAT
#export PROMPT_COMMAND
#export HISTFILE 

# shopt -s histappend

## set alternativ history
HISTSIZE=10000
export HISTSIZE
#unset HISTFILE
export HISTTIMEFORMAT="%F %T "
HISTFILE=~/history-`date '+%Y.%m.%d_%H%M'`
export HISTFILE
shopt -s histappend
shopt -s cmdhist
export PROMPT_COMMAND="history -a"

#################
## aliases
alias ah='/export/home/dstock/scripts/admin/ansible-hosts-mgt.py'
alias al="mv /home/dstock/var/ansible/log/ansible.log /home/dstock/var/ansible/log/`date +%Y-%m-%d_%H%M`_ansible.log"
alias an="/home/dstock/scripts/an.sh"
alias api="/home/dstock/scripts/api.sh"
alias b="echo '. /export/home/dstock/.bashrc'"
alias ccert="/home/dstock/scripts/admin/ccert.sh"
alias c='/export/home/dstock/scripts/connect.sh '
alias check_nrpe='/usr/lib64/nagios/plugins/check_nrpe'
alias ch='vi /export/home/dstock/scripts/lists/hosts; echo "/export/home/dstock/scripts/lists/hosts"'
alias ck-disk="/home/dstock/scripts/monitor/ck-disk.sh"
alias ck-ntp="/export/home/dstock/scripts/monitor/ck-ntp.sh"
alias ck-sat="/export/home/dstock/scripts/check-sat-postgres"
alias chg-ntp="/export/home/dstock/scripts/admin/chg-ntp-conf.sh"
alias ck='/export/home/dstock/scripts/ck.sh'
alias ck-re="/home/dstock/scripts/ck-cgi-reinstall.sh"
alias ck-nrpe='/export/home/dstock/scripts/admin/check-nrpe.sh'

alias cl='clear'

alias cluster='vi /export/home/dstock/scripts/cluster/suncluster-notes'
alias cp='cp -i'
alias dd='D="`date +%Y-%m-%d_%H%M`";echo $D'
alias d='D="KW`date +%W`_`date +%Y.%m.%d`_`date +%A`";echo $D'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gg='/export/home/dstock/scripts/admin/ds-lookup-group.sh'
alias g='/home/dstock/scripts/admin/ds-lookup-new.sh'
alias grep='grep --color=auto'
alias gt="'echo grep Host /home/dstock/tmp.txt|awk \'{print $2}\''"
alias gt="/home/dstock/scripts/grep-hosts.sh"
alias ham='/home/dstock/scripts/hammer.sh'
alias sat='/home/dstock/scripts/sat.sh'
alias hd="~/scripts/hd.sh"
alias h='history'
alias i='/export/home/dstock/scripts/ipa.sh'
alias kw="echo KW-${K}"
alias l1="ls -1"
alias ldap='/export/home/dstock/scripts/ldap.sh'
alias l='ls -la'
alias lm='ls -la |more'
alias ls='ls --color=auto'
alias lt='ls -latr'
alias lz='ls -Z'
alias mv='mv -i'
alias p='/home/dstock/scripts/p.sh'
alias ph='/export/home/dstock/scripts/phon.sh'
alias pkg='/root/bin/list_systems_with_pkg.py'
alias py='/home/dstock/scripts/py.sh'
alias q='/export/home/dstock/scripts/q.sh'
alias rc='/export/home/dstock/scripts/rconnect.sh '
alias ref='cat /export/home/dstock/scripts/lists/reference-systems.list '
alias rh='/export/home/dstock/scripts/security/ssh-host-remove.sh'
alias rm='rm -i'
alias set-ntp="/export/home/dstock/scripts/admin/set-ntp-clock.sh"
alias s='/export/home/dstock/scripts/s.sh'
alias sp1='du -x . | sort -n |cut -d\/ -f1-2|sort -k2 -k1,1nr|uniq -f1|sort -n|tail -20|cut -f2|xargs du -sxh'
alias sp2='find . -type f -mtime +30 -exec ls -la {} \;'
alias sp='du -ak . | sort -nru | head -30'
alias spv='du -ak /var | sort -nru | head -30'
alias sph='du -ak /home | sort -nru | head -30'
alias spr='du -akx --time / |egrep "J2EE|boot|home|var|dev" |sort -nru |head -30'
alias t='date +%H:%M'
alias tmp="/home/dstock/scripts/tmp.sh; echo '~/tmp.txt'"
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

INV=/home/dstock/script/list/hosts
