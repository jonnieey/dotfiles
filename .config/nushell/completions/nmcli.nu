# Custom completer for network connection names
def "nu-complete nmcli connections" [] {
    ^nmcli -t -f NAME connection show | lines
}

# Custom completer for active devices
def "nu-complete nmcli devices" [] {
    ^nmcli -t -f DEVICE device status | lines
}

# Custom completer for WiFi SSIDs
def "nu-complete nmcli wifi" [] {
    ^nmcli -t -f SSID device wifi list | lines | where $it != ""
}

export extern "nmcli" [
    --overview(-o)      # Overview mode
    --temporary(-t)     # Terse output
    --pretty(-p)        # Pretty output
    --version(-v)       # Show version
    --help(-h)          # Show help
]

# Connection Subcommands
export extern "nmcli connection" [
    action?: string@"nu-complete nmcli connection actions"
]

def "nu-complete nmcli connection actions" [] {
    [ "show", "up", "down", "add", "modify", "clone", "edit", "delete", "monitor", "reload", "load" ]
}

# nmcli connection show
export extern "nmcli connection show" [
    connection?: string@"nu-complete nmcli connections" # Connection name
    --active(-a)                                        # Show only active connections
]

# nmcli connection up
export extern "nmcli connection up" [
    id: string@"nu-complete nmcli connections"         # Connection to activate
]

# nmcli connection down
export extern "nmcli connection down" [
    id: string@"nu-complete nmcli connections"         # Connection to deactivate
]

# Device Subcommands
export extern "nmcli device" [
    action?: string@"nu-complete nmcli device actions"
]

def "nu-complete nmcli device actions" [] {
    [ "status", "show", "set", "connect", "reapply", "modify", "disconnect", "delete", "monitor", "wifi", "lldp" ]
}

export extern "nmcli device status" []

export extern "nmcli device show" [
    device?: string@"nu-complete nmcli devices"
]

export extern "nmcli device wifi" [
    action?: string@"nu-complete nmcli device wifi actions"
]

def "nu-complete nmcli device wifi actions" [] {
    [ "list", "connect", "rescan" ]
}

# nmcli device wifi connect
export extern "nmcli device wifi connect" [
    id?: string@"nu-complete nmcli wifi"
    --password(-p): string                     # WiFi password
]

# Radio Subcommands
export extern "nmcli radio" [
    type?: string@"nu-complete nmcli radio types"
]

def "nu-complete nmcli radio types" [] {
    [ "all", "wifi", "wwan" ]
}
