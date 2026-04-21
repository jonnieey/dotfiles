# ===============================
# True Black Catppuccin-style Theme (Cool / OLED)
# ===============================

# --- Base (TRUE BLACK) ---
bg0 = "#000000"
bg1 = "#0b0d10"
bg2 = "#111318"
bg3 = "#1a1d24"
bg4 = "#242833"

# --- Foreground (NO ORANGE / NO YELLOW) ---
fg0 = "#cdd6f4"   # main text (cool white)
fg1 = "#bac2de"
fg2 = "#a6adc8"
fg3 = "#9399b2"
fg4 = "#7f849c"

# --- Accents (cool only) ---
accent = "#89b4fa"     # blue
accent2 = "#b4befe"    # lavender
accent3 = "#94e2d5"    # teal

bright_red = "#f38ba8"
bright_green = "#a6e3a1"
bright_yellow = "#bac2de"   # neutralized (no yellow feel)
bright_blue = accent
bright_purple = accent2
bright_aqua = accent3
bright_orange = "#89b4fa"   # replaced with blue (no orange anywhere)

dark_red = "#b4637a"
dark_green = "#6f8f72"
dark_yellow = "#7f849c"
dark_blue = "#6c8ed4"
dark_purple = "#9d7cd8"
dark_aqua = "#6fb1a0"
dark_orange = "#7f849c"

# ===============================
# Completion
# ===============================
c.colors.completion.fg = [fg1, accent3, accent]
c.colors.completion.odd.bg = bg0
c.colors.completion.even.bg = bg0

c.colors.completion.category.fg = accent2
c.colors.completion.category.bg = bg2
c.colors.completion.category.border.top = bg2
c.colors.completion.category.border.bottom = bg2

c.colors.completion.item.selected.fg = fg0
c.colors.completion.item.selected.bg = "#1e2230"
c.colors.completion.item.selected.border.top = bg3
c.colors.completion.item.selected.border.bottom = bg3

c.colors.completion.item.selected.match.fg = accent
c.colors.completion.match.fg = accent

c.colors.completion.scrollbar.fg = fg2
c.colors.completion.scrollbar.bg = bg2

# ===============================
# Context menu
# ===============================
c.colors.contextmenu.disabled.bg = bg3
c.colors.contextmenu.disabled.fg = fg3

c.colors.contextmenu.menu.bg = bg1
c.colors.contextmenu.menu.fg = fg2

c.colors.contextmenu.selected.bg = "#1e2230"
c.colors.contextmenu.selected.fg = fg0

# ===============================
# Downloads
# ===============================
c.colors.downloads.bar.bg = bg0
c.colors.downloads.start.fg = bg0
c.colors.downloads.start.bg = accent

c.colors.downloads.stop.fg = bg0
c.colors.downloads.stop.bg = accent3

c.colors.downloads.error.fg = bright_red

# ===============================
# Hints (cool glow)
# ===============================
c.colors.hints.fg = bg0
c.colors.hints.bg = "rgba(137, 180, 250, 200)"
c.colors.hints.match.fg = fg0

# ===============================
# Keyhint widget
# ===============================
c.colors.keyhint.fg = fg4
c.colors.keyhint.suffix.fg = fg0
c.colors.keyhint.bg = bg0

# ===============================
# Messages
# ===============================
c.colors.messages.error.fg = bg0
c.colors.messages.error.bg = bright_red
c.colors.messages.error.border = bright_red

c.colors.messages.warning.fg = bg0
c.colors.messages.warning.bg = accent2
c.colors.messages.warning.border = accent2

c.colors.messages.info.fg = fg2
c.colors.messages.info.bg = bg0
c.colors.messages.info.border = bg0

# ===============================
# Prompts
# ===============================
c.colors.prompts.fg = fg1
c.colors.prompts.bg = bg2
c.colors.prompts.border = f"1px solid {accent}"
c.colors.prompts.selected.bg = "#1e2230"

# ===============================
# Statusbar (clean + vibrant)
# ===============================
c.colors.statusbar.normal.fg = fg2
c.colors.statusbar.normal.bg = bg0

c.colors.statusbar.insert.fg = bg0
c.colors.statusbar.insert.bg = bright_green

c.colors.statusbar.passthrough.fg = bg0
c.colors.statusbar.passthrough.bg = accent

c.colors.statusbar.private.fg = accent2
c.colors.statusbar.private.bg = bg0

c.colors.statusbar.command.fg = accent
c.colors.statusbar.command.bg = bg2

c.colors.statusbar.command.private.fg = accent2
c.colors.statusbar.command.private.bg = bg2

c.colors.statusbar.caret.fg = bg0
c.colors.statusbar.caret.bg = accent2

c.colors.statusbar.caret.selection.fg = bg0
c.colors.statusbar.caret.selection.bg = accent2

c.colors.statusbar.progress.bg = accent

c.colors.statusbar.url.fg = fg3
c.colors.statusbar.url.error.fg = bright_red
c.colors.statusbar.url.hover.fg = accent
c.colors.statusbar.url.success.http.fg = accent
c.colors.statusbar.url.success.https.fg = bright_green
c.colors.statusbar.url.warn.fg = accent2

# ===============================
# Tabs (minimal + glow)
# ===============================
c.colors.tabs.bar.bg = bg0

c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = accent2
c.colors.tabs.indicator.error = bright_red

c.colors.tabs.odd.fg = fg3
c.colors.tabs.odd.bg = bg2

c.colors.tabs.even.fg = fg3
c.colors.tabs.even.bg = bg2

c.colors.tabs.selected.odd.fg = accent
c.colors.tabs.selected.odd.bg = bg0

c.colors.tabs.selected.even.fg = accent
c.colors.tabs.selected.even.bg = bg0

c.colors.tabs.pinned.even.bg = accent3
c.colors.tabs.pinned.even.fg = bg0

c.colors.tabs.pinned.odd.bg = accent3
c.colors.tabs.pinned.odd.fg = bg0

c.colors.tabs.pinned.selected.even.bg = bg0
c.colors.tabs.pinned.selected.even.fg = accent

c.colors.tabs.pinned.selected.odd.bg = bg0
c.colors.tabs.pinned.selected.odd.fg = accent

# ===============================
# Webpage (force TRUE BLACK pages)
# ===============================
c.colors.webpage.bg = bg0

# Fonts

dfont = "JetBrains Mono Nerd Font"
dsize = "10pt"

c.fonts.default_family = f'{dfont}'
c.fonts.default_size = f'{dsize}'
c.fonts.completion.entry = f'{dsize} {dfont}'
c.fonts.completion.category = 'bold {dsize} {dfont}'
c.fonts.contextmenu = f'{dsize} {dfont}'
c.fonts.downloads = f'{dsize} {dfont}'
c.fonts.hints = f'{dsize} {dfont}'
c.fonts.keyhint = f'{dsize} {dfont}'
c.fonts.messages.error = 'italic {dsize} {dfont}'
c.fonts.messages.info = 'italic {dsize} {dfont}'
c.fonts.messages.warning = 'italic {dsize} {dfont}'
c.fonts.prompts = f'{dsize} {dfont}'
c.fonts.statusbar = f'{dsize} {dfont}'
c.fonts.tabs.selected = 'italic {dsize} {dfont}'
c.fonts.tabs.unselected = f'{dsize} {dfont}'

