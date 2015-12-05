#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Dustin Knie <nullpuppy@gmail.com>
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

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

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
# }}}

# pyenv virtualenv -- init if installed
command -v pyenv 2>&1 && eval "$(pyenv virtualenv-init -)"

typeset -U path
[[ -d ${HOME}/.bin ]] && path=( ${HOME}/.bin $path )
[[ -d ${HOME}/.nodebrew/current/bin ]] && path=( ${HOME}/.nodebrew/current/bin $path )
[[ -d ${HOME}/.local/android_sdk ]] && path=( $path ${HOME}/.local/android_sdk/tools ${HOME}/.local/android_sdk/platform-tools )

# zsh-bd
. $ZDOTDIR/plugins/bd/bd.zsh

# nodebrew things
# export NODEBREW_ROOT=/usr/local/var/nodebrew

ctrlp() {
  </dev/tty vim -c CtrlP
}
zle -N ctrlp

bindkey "^p" ctrlp


ctrlspace() {
    </dev/tty vim -c CtrlSpace
}
zle -N ctrlspace
bindkey "^ " ctrlspace
