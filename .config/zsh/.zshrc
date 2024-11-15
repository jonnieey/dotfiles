# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
EDITOR=nvim
TERMINAL=st

setopt autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#cursor shape on vim mode
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:*' color green
# NEWLINE=$'\n'
# PROMPT="%{%F{33}%}%~ %{%f%} ${NEWLINE}> "

eval "$(register-python-argcomplete pipx)"
eval "$(zoxide init zsh)"

export DISABLE_AUTO_TITLE="true"
# export BROWSER="qutebrowser"
export PRIVATE_BROWSER="qutebrowser -T -C ${HOME}/.config/qutebrowser/config-priv.py $@" 
export PAGER="less -R"

source ~/.config/zsh/aliases
source ~/.config/zsh/private_aliases_envs
. "$HOME/.cargo/env"

#completions
source ~/.football_complete.zsh
source ~/.spotify-player-complete.zsh

# export FZF_DEFAULT_OPTS="--color=bg+:#900048,bg:-1,spinner:#ff0e82,hl:#00ffb7 \
#                         --color=fg:#cdd6f4,header:#ff0e82,info:#cba6f7,pointer:#00ffb7 \
#                         --color=marker:#900048,fg+:#00ffb7,prompt:#cba6f7,hl+:#00ffb7"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"
