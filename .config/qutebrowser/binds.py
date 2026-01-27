config.unbind("d")
config.bind(
    "M",
    'hint links spawn mpv --vo=gpu --hwdec=vaapi --ytdl-format="bestvideo[height<=720]+bestaudio" --script-opts=ytdl_hook-ytdl_path=yt-dlp "{hint-url}"',
)
config.bind(";t", "hint userscript link translate")
config.bind(";T", "hint userscript all translate --text")
config.bind("<Ctrl+T>", "spawn --userscript translate")
config.bind("<Ctrl+Shift+T>", "spawn --userscript translate --text")
config.bind("Q", ":open --tab https://duckduckgo.com/?q=!qr+{url}")
config.bind("\\dm", ":set colors.webpage.darkmode.enabled true")
config.bind("\\dl", ":set colors.webpage.darkmode.enabled false")
config.bind(",a", "hint links spawn --userscript aria2-with-cookies {hint-url}")
#create a bind to copy links to a specific file
# config.bind(
#     ',a',
#     'hint links spawn -- sh -c "echo {hint-url} >> ~/Music/todownload.txt"'
# )
config.bind(',a', 'hint links spawn sh -c "echo \'{hint-url}\' >> ~/Music/todownload.txt"')
