PS1='\[\033[1;31m\]\W/\[\033[0m\] '

##### DEFAULTS #####

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

PROMPT_COLOR='35;1m'

export HISTCONTROL=ignoreboth
export EDITOR="nano"
export VISUAL="nano"

shopt -s histappend
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Color prompt
force_color_prompt=yes

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi



##### CUSTOM STARTS HERE #####

### FUNCTIONS

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Makes directory then moves into it
function mkcdr {
    mkdir -p -v $1
    cd $1
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

### ALIASES

## Keeping things organized
alias ls='ls'
alias ll='ls -l'
alias la='ls -A'
alias rm='mv -t ~/.local/share/Trash/files'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.bashrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias infoshot='weather;uptime;lsb_release -a;uname -a;scrot -d 5'
alias info='weather;uptime;lsb_release -a;uname -a'

## Moving around & all that jazz
alias back='cd $OLDPWD'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## Dir shortcuts
alias home='cd ~/'
alias documents='cd ~/documents'
alias downloads='cd ~/downloads'
alias books='cd ~/eBooks'
alias images='cd ~/images'
alias packages='cd ~/Packages'
alias aruby='cd ~/Ruby'
alias torrents='cd ~/'
alias videos='cd ~/videos'
alias webdesign='cd ~/Web\ Design'
alias localhost='cd /var/www'

## App-specific
alias nano='nano -W -m'
alias music='ncmpcpp'
alias ftp='ncftp Personal'
alias wget='wget -c'
alias install='sudo apt-get install'
alias scrot='scrot -c -d 5'
alias version='apt-cache policy'
alias cpufreq='cat /proc/cpuinfo'

## Easy script callin'
alias show-info='~/.bin/info.pl'
alias show-colors='~/scripts/colors.sh'

## Sudo fixes
alias install='sudo apt-get install'
alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade'
alias remove='sudo apt-get remove'
alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
alias cleanup='sudo apt-get autoclean && sudo apt-get autoremove && sudo apt-get clean && sudo apt-get remove && orphand'
alias updatedb='sudo updatedb'

## Dev related
alias restart-apache='sudo /etc/init.d/apache2 restart'

## Misc
alias edit='nano'

# Get weather (replace the 48183 in the url with your own zipcode, call it by typing weather)
weather ()
{ 
declare -a WEATHERARRAY 
WEATHERARRAY=( `elinks -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+48183&btnG=Search" | grep -A 5 -m 1 "Weather for" | grep -v "Add to "`) 
echo ${WEATHERARRAY[@]} 
}

# Get IP (call with myip)
function myip {
  myip=`elinks -dump http://checkip.dyndns.org:8245/`
  echo "${myip}"
}


export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
