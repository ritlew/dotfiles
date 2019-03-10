#
# ~/.bashrc
#

alias drm='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi -f $(docker images -a -q)'
alias aurc='__aurc'

__aurc() { git clone https://aur.archlinux.org/"$@".git ~/aur/"$@"; }

GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/.bash-git-prompt/gitprompt.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
