$env.config.keybindings ++= [{
    name: clear_line
    modifier: control
    keycode: char_u
    mode: vi_insert
    event: [{ edit: Clear }]
}]
