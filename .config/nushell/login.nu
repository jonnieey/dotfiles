use std/util "path add"
path add "~/.local/myscripts-bin"

if ((tty | str trim) == "/dev/tty5") {
    exec startx
}
