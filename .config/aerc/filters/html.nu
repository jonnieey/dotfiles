#!/bin/bash
# aerc filter which runs w3m using socksify (from the dante package) to prevent
# any phoning home by rendered emails
export SOCKS_SERVER="127.0.0.1:1"
# For nushell
# let-env SOCKS_SERVER = "127.0.0.1:1"
socksify w3m -T text/html -cols "$(tput cols)" -dump -o display_image=false -o display_link_number=true
