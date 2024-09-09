export PATH="$PATH:${HOME}/.local/bin:${HOME}/.local/myscripts-bin/"

if [[ $(tty) == /dev/tty5 ]]; then
    exec startx
fi
