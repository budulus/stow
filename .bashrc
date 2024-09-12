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

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

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
alias ll='ls -latr --color'
alias la='ls -A'
alias l='ls -CF'
alias fiji='~/software/Fiji.app/ImageJ-linux64'
alias jl='mamba activate general && jupyter lab --notebook-dir=/home/raoul/Dropbox/IPNB --browser=opera'
alias gen='mamba activate general'
#alias vc='sudo openconnect -u rhopf@staff-net.ethz.ch --useragent=AnyConnect -g staff-net sslvpn.ethz.ch'
alias vpnc='~/scripts/connect_vpn.sh'
alias vpnd='sudo pkill openconnect'
alias rdp='remmina -c ~/.local/share/remmina/group_rdp_quick-connect_spinoff-senecell-ws2-ethz-ch.remmina'
alias rdpcomsol='remmina -c ~/.local/share/remmina/group_rdp_comsol_mavt-zfm-w105w-d-ethz-ch.remmina'
alias up='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias ethz='oathtool --totp --base32 "PUNITGK62NRAVRBOON6H7SRT6U2GJ6EI"'
alias i3e='code .config/i3/config'
alias tlpgui='flatpak run com.github.d4nj1.tlpu'
alias ..='cd ..'
alias br="vscode .bashrc"
alias ico='vscode $(fzf --preview="bat --color=always {}")'
alias mg='mamba activate general'
alias mutt='neomutt'
alias phonec='nmcli dev wifi connect "placksiphone" password "EWUPOWEK"'
alias homec='nmcli dev wifi connect "Placksi-Net" password "bagsibudu279"'
alias ethc='nmcli dev wifi connect "eth-5" --802-11-wireless-security.key-mgmt wpa-eap --802-11-wireless-security.eap peap --802-11-wireless-security.identity "rhopf@staff-net.ethz.ch" --802-11-wireless-security.password "39Ura,Mgbcdef"'

alias listwifi='nmcli dev wifi list'

# paths
export PATH="$PATH:/home/raoul/bin"
export PATH="$PATH:/home/raoul/scripts"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/raoul/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/raoul/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/raoul/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$PATH:/home/raoul/miniforge3/bin"
    fi
fi
unset __conda_setup

if [ -f "/home/raoul/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/raoul/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.fzf-key-bindings.bash ] && source ~/.fzf-key-bindings.bash

alias ipr='function _fzf_ipr() {
    local dir=${1:-.}  # Default to current directory if none provided
    find "$dir" -type f | fzf --preview "bat --style=numbers --color=always --line-range=:500 {}" --bind "enter:execute(bat --style=numbers --color=always {})"
}; _fzf_ipr'