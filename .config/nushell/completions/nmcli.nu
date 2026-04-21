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

# Device aliases  
alias "nmcli d" = nmcli device  
alias "nmcli d s" = nmcli device status  
alias "nmcli d sh" = nmcli device show  
alias "nmcli d w" = nmcli device wifi  
alias "nmcli d w l" = nmcli device wifi list  
alias "nmcli d w c" = nmcli device wifi connect  
alias "nmcli d w r" = nmcli device wifi rescan  
alias "nmcli d co" = nmcli device connect  
alias "nmcli d di" = nmcli device disconnect  
alias "nmcli d d" = nmcli device delete  
  
# Connection aliases  
alias "nmcli c" = nmcli connection  
alias "nmcli c s" = nmcli connection show  
alias "nmcli c sh" = nmcli connection show  
alias "nmcli c u" = nmcli connection up  
alias "nmcli c d" = nmcli connection down  
alias "nmcli c a" = nmcli connection add  
alias "nmcli c m" = nmcli connection modify  
alias "nmcli c e" = nmcli connection edit  
alias "nmcli c de" = nmcli connection delete  
  
# Networking aliases  
alias "nmcli n" = nmcli networking  
alias "nmcli n on" = nmcli networking on  
alias "nmcli n of" = nmcli networking off  
  
# Radio aliases  
alias "nmcli r" = nmcli radio  
alias "nmcli r w" = nmcli radio wifi  
alias "nmcli r ww" = nmcli radio wwan  
alias "nmcli r a" = nmcli radio all  
  
