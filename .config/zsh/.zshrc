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
export BROWSER="qutebrowser"
export PRIVATE_BROWSER="qutebrowser -T -C ~/.config/qutebrowser/config-priv.py $@" 

source ~/.config/zsh/aliases
source ~/.config/zsh/private_aliases_envs
