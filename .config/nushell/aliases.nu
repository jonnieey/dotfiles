alias fontprev = fontpreview-ueberzug -s 30 -b '#000000' -f '#ffffff' -t 'ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n<!-- != == ->\n-| #[ |> <$> ~@ 😊\n✈️\n😀\n👋\n😁\n👌\n👍\n👎\n🤷‍♂️\n🤷‍♀️'

alias grep = grep --color=auto
alias restartnm = sudo systemctl restart NetworkManager
alias ddgr = ddgr -n 5 --unsafe --colors ofglxy
alias mntand = jmtpfs ~/.android_mount/
alias mpvc = mpvc -S "$XDG_RUNTIME_DIR/.umpv_socket"
alias spt = spotify_player

def run-nchat [service: string, ...args] {
    let path = $"($env.HOME)/.local/share/nchat/($service)"
    nchat -d $path ...$args
}

def tchat [...args] { run-nchat telegram ...$args }
def wchat [...args] { run-nchat whatsapp ...$args }
def kchat [...args] { run-nchat nekochat ...$args }

def l [...paths: string] {
    let paths = if ($paths | is-empty) { ["."] } else { $paths }
    ls ...$paths | grid -c
}
def la [...paths: string] {
    let paths = if ($paths | is-empty) { ["."] } else { $paths }
    ls -a ...$paths | grid -c
}
def vwhich [cmd: string] {
    let editor = ($env.EDITOR? | default "vim")
    let path = (which $cmd | get path | to text -n)

    if ($path | is-empty) {
        print $"Command ($cmd) not found"
    } else {
        ^$editor $path
    }
}
# anit() {
#   command anit "$@" | sed 's/\(.*\)-\(.*\)/\1\t\2/' | column -t -s $'\t' -o - | colorize -c cyan
# }
