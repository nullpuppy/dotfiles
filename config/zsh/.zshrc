#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Move vim/vimrc to xdg compliant location
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Use Liquidprompt
source ~/.config/liquidprompt/liquidpromptrc
source ~/.config/liquidprompt/liquidprompt

# Aliases {{{
# tmux stuff
if [[ -e $XDG_CONFIG_HOME/tmux/config ]]; then
    alias tmux="tmux -u2 -f $XDG_CONFIG_HOME/tmux/config"
else
    alias tmux="tmux -u2"
fi

ta() {
    [[ -z $1 ]] && tmux attach || tmux attach -t $1
}
tk() {
    [[ -z $1 ]] && return 1
    tmux kill-session -t $1
}
tls() { tmux ls }
tn() {
    [[ ! -z $1 ]] && tmux has-session &> /dev/null && tmux has-session $1 &> /dev/null && return 1
    [[ ! -z $1 ]] && tmux new-session -d -s $1 || tmux new-session -d
}
tna() {
    [[ ! -z $1 ]] && tmux has-session &> /dev/null && tmux has-session $1 &> /dev/null && return 1
    [[ ! -z $1 ]] && tmux new-session -s $1 || tmux new-session
}

# virtualenv stuff.
[[ -z $VIRTUALENVS ]] && VIRTUALENVS=${HOME}/.virtualenvs

ve() {
    [[ ! -z $1 ]] && [[ -d ${VIRTUALENVS}/$1 ]] && source ${VIRTUALENVS}/$1/bin/activate || return 1
}

ce() {
    [[ ! -e ${VIRTUALENVS} ]] && mkdir -p ${VIRTUALENVS}
    [[ -z $1 ]] || [[ -e ${VIRTUALENVS}/$1 ]] && return 1
    [[ ! -z $2 ]] && USEPY="-p $2" && [[ ! -f $2 ]] && return 1
    which virtualenv > /dev/null && VE=virtualenv || which virtualenv2 > /dev/null && VE=virtualenv2
    [[ -z $VE ]] && return 1
    [[ -n $VE ]] && echo $VE $USEPY $VIRTUALENVS/$1
    unset -v VE USEPY
}
# }}}

typeset -U path
[[ -d ${HOME}/.bin ]] && path=( ${HOME}/.bin $path)
