#
# ~/.bashrc
#
 
alias ls='ls --color=auto'

if [ $(command -v git) ]; then
    git config --global core.editor "vim"
    alias gitlog="git log --pretty=format:'%C(yellow)%h %Cred%ad %C(magenta)%an%Cgreen%d %Creset%s' --date=short"
fi

if [ $(command -v i3-sensible-terminal) ]; then
    export TERMINAL=sakura
fi

if [ $(command -v docker) ]; then
    alias drm='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi -f $(docker images -a -q)'
fi

case "$(uname -s)" in
    Linux*)
        # git prompt
        if [ -d ~/.bash-git-prompt/ ]; then
            GIT_PROMPT_ONLY_IN_REPO=1
            GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 
            GIT_PROMPT_SHOW_UNTRACKED_FILES=no
            source ~/.bash-git-prompt/gitprompt.sh
        fi

        if [ -f "/etc/arch-release" ]; then
            alias aurc='__aurc'
            __aurc() { git clone https://aur.archlinux.org/"$@".git ~/aur/"$@"; }
        fi
        ;;

    MINGW*)     
        if [ $(which python) ]; then
            alias python="winpty python.exe"
        fi
        ;;
esac

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

if [ -f ~/.bash_specific ]; then
    . ~/.bash_specific
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
