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

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME='Nord'

# Customize to your needs...
# Enable starship if it's installed
if type starship >/dev/null; then
    export STARSHIP_CONFIG=~/.config/starship/starship.toml
    eval "$(starship init zsh)"
else
    autoload -Uz promptinit
    promptinit
    # Otherwise, enable powerlevel10k

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Powerlevel 10k
    [[ -e ~/.config/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
    prompt powerlevel10k

    # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
fi

# Move vim/vimrc to xdg compliant location
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export VIMINIT='if has("nvim") let $MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim"; else let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"; endif | source $MYVIMRC'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-default-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

typeset -U path
[[ -d ${HOME}/.bin ]] && path=( ${HOME}/.bin $path )
[[ -d ${HOME}/.local/bin ]] && path=( ${HOME}/.local/bin $path )
[[ -d ${HOME}/code/go/bin ]] && path=( $path ${HOME}/code/go/bin )

# zsh-bd
. $ZDOTDIR/plugins/bd/bd.zsh

# ^<space> via zsh {{{
ctrlspace() {
	</dev/tty nvim -c CtrlSpace
}
zle -N ctrlspace
bindkey "^ " ctrlspace
# }}}

# cwd history prioritization
[[ -f ${ZDOTDIR:-$HOME}/plugins/zsh-prioritize-cwd-history/ ]] && source ${ZDOTDIR:-$HOME}/plugins/zsh-prioritize-cwd-history/zsh-prioritize-cwd-history.zsh

# MacOS specific things {{{
# iterm2 shell integration.
if [[ $(uname) == 'Darwin' ]]; then
    [[ -f ${HOME}/.iterm2_shell_integration.zsh ]] && source ${HOME}/.iterm2_shell_integration.zsh
    [[ $(which brew && which asdf) ]] && . $(brew --prefix asdf)/asdf.sh
fi
# }}}

# Ensure asdf is functional
[[ -e ${HOME}/.local/share/asdf/asdf.sh ]] && . $HOME/.local/share/asdf/asdf.sh

[[ $(type asdf >/dev/null && asdf where rust >/dev/null) ]] && source $(asdf where rust)/env
# Direnv
eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }

export GHCUP_USE_XDG_DIRS=true
#
# Misc things like keys and such.
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.alias ]] && source "${ZDOTDIR:-$HOME}/.zshrc.alias"
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source "${ZDOTDIR:-$HOME}/.zshrc.local"
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.sec ]] && source "${ZDOTDIR:-$HOME}/.zshrc.sec"

