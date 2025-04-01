ZDOTDIR="$HOME/.config/zsh"
EDITOR=nvim
TERMINAL=st
PRIVATE_BROWSER="qutebrowser -T -C /home/sato/.config/qutebrowser/config-priv.py $@" 
BROWSER="qutebrowser"

if [ -e /home/sato/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sato/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
