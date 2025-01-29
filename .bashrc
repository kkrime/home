# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# 	# We have color support; assume it's compliant with Ecma-48
# 	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# 	# a case would tend to support setf rather than setaf.)
# 	color_prompt=yes
#     else
# 	color_prompt=
#     fi
# fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# NOTES
# TO generate self-signing certificate:
# https://www.openldap.org/pub/ksoper/OpenLDAP_TLS_obsolete.html#4.1
# openssl req -newkey rsa:2048 -x509 -nodes -out server.pem -keyout server.pem -days 364

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim=/usr/bin/vim
alias vimdiff=/usr/bin/vimdiff

# misc
export LIBRARY_PATH="/opt/homebrew/lib" 
export CPATH="/opt/homebrew/include"

# go
# export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/local/go/
export GOROOT=/opt/homebrew/Cellar/go/1.22.0/libexec/
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/go/bin
export GOTRACEBACK=single 

# rust
export PATH=/Users/iraq/.cargo/bin:$PATH

# Brew
# export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/homebrew/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
alias ibrew='arch -x86_64 /usr/local/homebrew/bin/brew'
# brew install starship nvim bat exa tmux fd git-delta rg rm-improved zellij atuin

# /usr/local/bin
export PATH=$PATH:/usr/local/bin

# rust utilities
alias ls='exa --color=always'
alias lt='ll -snew -r'
alias b='bat'

# python
# below is needed for 'arch -x86_64 pyenv install 3.8.13'
# export LDFLAGS="-L/opt/homebrew/lib"; export CPPFLAGS="-I/opt/homebrew/include"
# below is needed for 'make install_deps'
# LIBRARY_PATH=$LIBRARY_PATH:/usr/local/homebrew/opt/openssl\@1.1/lib/
export PATH=/usr/local/bin:~/.pyenv/versions/3.8.13/bin:$PATH

 # added by Nix installer
if [ -e /Users/iraq/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/iraq/.nix-profile/etc/profile.d/nix.sh; fi

# git autocomplete commands when pressing TAB
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# sudo
alias s='sudo'

# rip grep with colour
alias rgm='rg'
alias rgi='rg --color=always -i'
# alias rgg='rg --color=always --max-depth 1'
alias rgg=rg '--color=always --max-depth 1'
alias rgm='rg --color=never'
alias rggm='rg --color=never--max-depth 1'

# quick access to ~/.bashrc
alias .bash='nvim ~/.bashrc'

# replace rip with rip
alias rm='rip'

# github
alias cpr='~/.tools/github/github_create_PR.sh'
alias pcpr='~/.tools/github/github_push_and_create_PR.sh'
alias cmpcpr='~/.tools/github/github_commit_push_and_create_PR.sh'
alias cmp='~/.tools/commit_push.sh'

# git 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion 2>/dev/null 
fi
alias g="git"
__git_complete g __git_main

# awk
alias ch=choose

# vim
alias v='nvim -O'

# cat
alias c='cat'

# curl
# alias curl=/opt/homebrew/Cellar/curl/7.85.0/bin/curl

# aws
alias awsp="source _awsp"

# source ~/.airflow

alias python="$(pyenv which python)"
alias pip="$(pyenv which pip)"

alias sk='cd ~/go/src/sky'

# nvim dev
alias config='cd ~/.config/nvim/lua/plugins/'
alias plugins='cd ~/.local/share/nvim/lazy/'


# svelte
export PNPM_HOME="/Users/iraq/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH=$PATH:/opt/homebrew/Cellar/pnpm\@8/8.15.8_1/bin


# starship
eval "$(starship init bash)"
# zellij
eval "$(zellij setup --generate-auto-start bash )"
# autin
source ~/.bash-preexec.sh
eval "$(atuin init bash --disable-up-arrow)"

# install Utils
# brew tap cjbassi/ytop
# brew install ytop bandwhich
# . "$HOME/.cargo/env"


