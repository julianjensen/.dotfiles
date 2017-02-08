alias today='date +"%A, %B %-d, %Y"'
alias now='date +"%T"'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias t='clear;tail -50'
alias c='clear'

alias ping='ping -c 10 -s.2'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# nmcli -t -f DEVICE connection show --active
# ip route show | egrep '^default' | cut -d' ' -f 5

alias xclip='xclip -selection c'
alias ack='ack -k --ignore-dir=node_modules'

alias inst='sudo apt-get install'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get update && sudo apt-get upgrade && sudo apt autoremove'
alias search='apt-cache search'

if hash nmcli 2>/dev/null; then
	export NIC=$(nmcli -t -f DEVICE c s -a)
	alias dnstop='sudo dnstop -l 5 '${NIC}
	alias vnstat='sudo vnstat -i '${NIC}
	alias iftop='sudo iftop -i '${NIC}
	alias tcpdump='sudo tcpdump -i '${NIC}
	alias ethtool='sudo ethtool '${NIC}
fi

alias grep='egrep --color=auto'

alias rm='rm --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='clear;ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='clear;ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## get GPU ram on desktop / laptop##
alias gpumem='grep -i --color memory /var/log/Xorg.0.log'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# top is atop, just like vi is vim
alias top='atop'

## Memcached server status  ##
alias mcdstats='/usr/local/bin/memcached-tool 127.0.0.1:11211 stats'
alias mcdshow='/usr/local/bin/memcached-tool 127.0.0.1:11211 display'

## quickly flush out memcached server ##
alias flushmcd='echo "flush_all" | nc 127.0.0.1 11211'

## redis flush
alias reflush='redis-cli flushall'

alias ps2='ps -ef | grep -v $$ | grep -i '
alias psg='ps -Helf | grep -v $$ | grep -i -e WCHAN -e '

# Sort by most recently modified
alias lt='ls -Falrt --human-readable'

alias filetree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

###
# time to upgrade `ls`

# always use color, even when piping (to awk,grep,etc)
if ls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias la='ls -lAFh ${colorflag} --group-directories-first'
alias ll='ls -lFh ${colorflag} --group-directories-first'
alias lsd='ls -l | grep "^d"' # only directories
alias gls='git br -l'
###

# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

###
# GIT STUFF

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'


# Networking. IP address, dig, DNS
alias ext-ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dig="dig +nocmd any +multiline +noall +answer"

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
alias g="git"
alias ungz="gunzip -k"

# File size
alias fs="stat -f \"%z bytes\""

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

alias lls="ls -Fla $1 $2 $3 $4 $5  | awk '{ print; x=x+\$5 } END { print \"total bytes = \",x }'"

alias machine="echo you are logged in to `uname -a | cut -f2 -d' '`"
alias connections='sudo lsof -n -P -i +c 15'

alias rl='. ~/.bash_aliases'

alias bigfiles="find . -type f 2>/dev/null | xargs du -a 2>/dev/null | awk '{ if ( \$1 > 5000) print \$0 }'"
alias verybigfiles="find . -type f 2>/dev/null | xargs du -a 2>/dev/null | awk '{ if ( \$1 > 500000) print \$0 }'"

alias back='cd $OLDPWD'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
type -t hd > /dev/null || alias hd="hexdump -C"


# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias ts="date +%s"

alias ns="netstat -vWeepl --tcp"
alias nsn="netstat -vWneepl --tcp"
alias ducks='du -cks * | sort -rn | head'

alias jdev="ssh julian@julian.dev.corp.pvt"

alias bastion='ssh -A ubuntu@ec2-52-91-213-165.compute-1.amazonaws.com'
alias wakework='wakeonlan 80:fa:5b:19:84:0c'

