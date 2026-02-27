# config.nu
#
# Installed by:
# version = "0.109.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.history.max_size = 10000
$env.config.use_kitty_protocol = true


$env.CARGO_HOME = '/home/sato/.cargo'

use std/util "path add"
path add "~/.local/bin"
path add "/home/sato/bin"
path add "~/.local/myscripts-bin"
path add ($env.CARGO_HOME | path join "bin")

$env.PATH = ($env.PATH | uniq)
$env.PAGER = 'less -R'
$env.PRIVATE_BROWSER = 'qutebrowser -T -C /home/sato/.config/qutebrowser/config-priv.py '
$env.TERM = 'kitty'
$env.EDITOR = 'nvim'

source ($nu.default-config-dir | path join "private_env.nu")
source ($nu.default-config-dir | path join "aliases.nu")
source ($nu.default-config-dir | path join "bindings.nu")

def fg [] {
    let jobs = (job list)
    if ($jobs | is-not-empty) {
        job unfreeze ($jobs | get id | last)
        } else {
            print "No background jobs found"
        }

    }

# load startship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ($nu.default-config-dir | path join "completions" "uv-completions.nu")
source ($nu.default-config-dir | path join "completions" "git-completions.nu")
source ($nu.default-config-dir | path join "completions" "nmcli.nu")
source ($nu.default-config-dir | path join "completions" "tmpmail.nu")
source ($nu.home-dir | path join ".zoxide.nu")
