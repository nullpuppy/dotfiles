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
# Enable starship if it's installed
if type starship >/dev/null; then
    export STARSHIP_CONFIG=~/.config/starship/starship.toml
    eval "$(starship init zsh)"
else
    # Otherwise, enable powerlevel10k

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Powerlevel 10k
    [[ -e ~/.config/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
    prompt -s powerlevel10k
fi


# Move vim/vimrc to xdg compliant location
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export VIMINIT='if has("nvim") let $MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim"; else let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"; endif | source $MYVIMRC'

# Use Liquidprompt
# source ~/.config/liquidprompt/liquidpromptrc
# source ~/.config/liquidprompt/liquidprompt


# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-default-dark.sh"
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
# command -v pyenv > /dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"
# docker-machine init
# command -v docker-machine > /dev/null 2>&1 && [[ $(docker-machine status default) == "Running" ]] && eval "$(docker-machine env default)"

# iterm2 shell integration.
[[ -f ${HOME}/.iterm2_shell_integration.zsh ]] && source ${HOME}/.iterm2_shell_integration.zsh

typeset -U path
[[ -d ${HOME}/.bin ]] && path=( ${HOME}/.bin $path )
[[ -d ${HOME}/.nodebrew/current/bin ]] && path=( ${HOME}/.nodebrew/current/bin $path )
[[ -d ${HOME}/.local/android_sdk ]] && path=( $path ${HOME}/.local/android_sdk/tools ${HOME}/.local/android_sdk/platform-tools )
[[ -d ${HOME}/code/go/bin ]] && path=( $path ${HOME}/code/go/bin )

# Golang things {{{
[[ -d ${HOME}/code/go ]] && export GOPATH=${HOME}/code/go
export GO15VENDOREXPERIMENT=1
# }}}

# zsh-bd
. $ZDOTDIR/plugins/bd/bd.zsh

# nodebrew things
[[ -f /usr/local/var/nodebrew ]] && export NODEBREW_ROOT=/usr/local/var/nodebrew

# ^p/^<space> via zsh {{{
ctrlp() {
  </dev/tty nvim -c CtrlP
}
zle -N ctrlp

bindkey "^p" ctrlp

ctrlspace() {
    </dev/tty nvim -c CtrlSpace
}
zle -N ctrlspace
bindkey "^ " ctrlspace
# }}}

# cwd history prioritization
[[ -f ${ZDOTDIR:-$HOME}/plugins/zsh-prioritize-cwd-history/ ]] && source ${ZDOTDIR:-$HOME}/plugins/zsh-prioritize-cwd-history/zsh-prioritize-cwd-history.zsh

# Misc things like keys and such.
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.sec ]] && source "${ZDOTDIR:-$HOME}/.zshrc.sec"
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source "${ZDOTDIR:-$HOME}/.zshrc.local"

# Ensure asdf is functional
[[ $(which brew && which asdf) ]] && . $(brew --prefix asdf)/asdf.sh
# Direnv
eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }

[[ $(which asdf && asdf where rust 2>/dev/null) ]] && source $(asdf where rust)/env

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Use exa
if type exa >/dev/null; then
    alias ll="exa -l"
    alias la="exa -la"
    alias lt="exa -lrtmodified"
    alias lc="exa -lt"
fi
