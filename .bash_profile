#!/usr/bin/env bash

stty -ixon # Disable ctrl-s and ctrl-q

quiet=1

log() {
    [ -n "$quiet" ] || printf "\e[0;32m%s\e[0m" "$1"
}

logline() {
    [ -n "$quiet" ] || printf "\e[0;32m%s\e[0m\n" "$1"
}


##
## PATHS
##

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/lib/llvm-latest/bin:$HOME/.rvm/bin:$HOME/.rvm/gems/ruby-2.4.0@global/bin:$HOME/.rvm/rubies/ruby-2.4.0/bin:$HOME/bin:/usr/lib/jvm/java-9-oracle/bin:/usr/lib/jvm/java-9-oracle/db/bin:$HOME/code/wabt/bin:$JAVA_HOME/bin:/usr/local/go/bin:$HOME/.rvm/bin:$HOME/.yarn/bin:/mnt/c/Windows/System32:/mnt/c/Windows/System32/WindowsPowerShell/v1.0:$HOME/WebStorm/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export NODE_PATH=/usr/lib/node_modules:/usr/local/lib/node_modules

if [[ -d "$HOME/.rvm/bin" ]]; then
    PATH="$PATH:$HOME/.rvm/bin:$HOME/.yarn/bin"
fi

if [[ -d "$HOME/.yarn/bin" ]]; then
    PATH="$PATH:$HOME/.yarn/bin"
fi

export PATH

#export PATH="${PATH}:/usr/local/go/bin:$HOME/code/emsdk:$HOME/code/emsdk/fastcomp/emscripten:$HOME/code/emsdk/fastcomp/bin:$HOME/code/emsdk/node/8.9.1_64bit/bin:$HOME/code/wabt/bin"
#export PATH="${PATH}:/usr/local/go/bin"

eval "$(direnv hook bash)"
export PM=yarn

log "reading bash scripts in the home directory..."

# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for bashscript in ~/.{bash_prompt,extra,exports,bash_aliases,functions}; do
    [ -r "$bashscript" ] && source "$bashscript"
done
unset bashscript

#logline "starting ssh-agent"

#eval "$(ssh-agent -s)" >/dev/null
#ssh-add -q /home/julian/.ssh/id_rsa >/dev/null

log "colorizing all the things..."

# generic colorizer, needs `apt install grc`
GRC=$(command -v grc)
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
    then
        alias colourify="$GRC -es --colour=auto"
        alias configure='colourify ./configure'
        for app in {diff,make,gcc,g++,ping,traceroute}; do
            alias "$app"='colourify '$app
    done
fi

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

##
## BASH HISTORY
##

# timestamps for later analysis. www.debian-administration.org/users/rossen/weblog/1
export HISTTIMEFORMAT='%F %T '
export HISTFILE=${HOME}/.bash_history

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history

##
## BETTER `cd`
##

shopt -s nocaseglob;
shopt -s cdspell;
shopt -s histappend                             # append to history, don't overwrite it
shopt -s autocd

GOPATH="$HOME/go"
DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0

export DISPLAY
export GOPATH

logline "okay"
log "setting up z..."

##
## z beats cd most of the time.
##
## github.com/rupa/z
##
if [[ -f ~/code/z/z.sh ]]; then
    # shellcheck source=~/code/z/z.sh
    . ~/code/z/z.sh
fi

export CC=clang
export CXX=clang++

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
## COLORS
## LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36':
##

. "/home/julian/.local/share/lscolors.sh"
export LS_COLORS

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export INCLUDE=/usr/local/include:/mnt/d/Users/Julian/code/emsdk/fastcomp/lib/clang/10.0.0/include:/usr/include/x86_64-linux-gnu:/usr/include
export WSLENV=INCLUDE/l

logline "okay"
log "bash completion and other bash scripts from ~/.bash.d ..."

# Mostly bash completion scripts in there
for bscript in ~/.bash.d/*.sh; do source "$bscript"; done

if [[ -d "$HOME/.cargo" ]]; then
    . "$HOME/.cargo/env"
fi

logline "okay"
logline "startup .bash_profile finished okay"
