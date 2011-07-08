#!/bin/bash
#############################################################################
#
# FILE:         050_misc_config.sh
#
# DESCRIPTION:  
#
#############################################################################


# Section: Files and directories (ENV) {{{
#############################################################################

# Directories
export DDOC=$HOME/doc
export DMEDIA=$HOME/media
export DBACKUP=$HOME/backup
export DDOWN=$HOME/comms/downloads
export DOTHER=$HOME/other
export DADMIN=$DOTHER/admin
export DSYSDATA=$DADMIN/data
export DDROPBOX=$HOME/comms/Dropbox
export DBASH=$HOME/.bash.d
export DDESKTOP=$DOTHER/Desktop
export DAPTCACHE=/var/cache/apt/archives

# Files
export FSYSLOG=/var/log/syslog
export FILOG=$DSYSDATA/install.log


#############################################################################
# }}}

# Section: Apps {{{
#############################################################################

export DIFF=vimdiff
export EDITOR=vim

if which vimpager > /dev/null 2>&1; then
   export PAGER=vimpager
elif which most > /dev/null 2>&1; then
   export PAGER=most
else
   export PAGER='less -R'
fi

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#############################################################################
# }}}   

# Section: Prompt {{{
#############################################################################

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt Items:
# 
#   \u              Username of the current user
#   \h              Hostname up to the first '.'
#   \w              Current working directory
#   $debian_chroot  Current chroot (if any)
#   `__git_ps1`     Current git branch if any
#
PS1NOCOLOR='\[\033[0m\]${debian_chroot:+($debian_chroot)}\u@\h:\w`__git_ps1`\$ '
PS1NOCOLOR='\u@\h:\w`__git_ps1`\$ '
PS1="\[\033[0m\]$PS1NOCOLOR"

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

COLOR_BLACK="\[\033[0;30m\]"
COLOR_RED="\[\033[0;31m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_BROWN="\[\033[0;33m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_PURPLE="\[\033[0;35m\]"
COLOR_CYAN="\[\033[0;36m\]"
COLOR_LIGHT_GRAY="\[\033[0;37m\]"
COLOR_DARK_GRAY="\[\033[1;30m\]"
COLOR_LIGHT_RED="\[\033[1;31m\]"
COLOR_LIGHT_GREEN="\[\033[1;32m\]"
COLOR_YELLOW="\[\033[1;33m\]"
COLOR_LIGHT_BLUE="\[\033[1;34m\]"
COLOR_LIGHT_PURPLE="\[\033[1;35m\]"
COLOR_LIGHT_CYAN="\[\033[1;36m\]"
COLOR_WHITE="\[\033[1;37m\]"
COLOR_NONE="\[\033[m\]"


set_prompt_color()
{
   local COLOR=${1:-$COLOR_NONE}
   # [[ -z $COLOR ]] && COLOR=$COLOR_NONE
   PS1BAK="$PS1"
   PS1="${COLOR}${PS1NOCOLOR}${COLOR_NONE}"
}  

default_prompt_color()
{
   PS1='\[\033[0m\]$PS1NOCOLOR'
}


#############################################################################
# }}}

# Section: History {{{
#############################################################################

# Don't put duplicate lines in the history and also don't save lines
# that begin with spaces
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="ls:cd:pwd"

#############################################################################
# }}}   



# Add my admin scripts to the path
pathprepend "$DADMIN/scripts"
pathprepend "$DOTHER/run/bin"

# Add user's Cabal binaries to the path
pathprepend "$HOME/.cabal/bin/"

pathprepend "$DDROPBOX/todo"


# an argument to the cd builtin command that is not a directory is assumed to
# be the name of a variable whose value is the directory to change to.
shopt -s cdable_vars


# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# vim: ft=bash fdm=marker expandtab ts=3 sw=3 :

