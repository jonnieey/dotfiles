config.load_autoconfig(False)
config.set("content.cookies.accept", "all", "chrome-devtools://*")
config.set("content.cookies.accept", "all", "devtools://*")
c.content.geolocation = False
config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")
# config.set(
#     "content.headers.user_agent",
#     "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
#     "https://web.whatsapp.com/",
# )
# config.set(
#     "content.headers.user_agent",
#     "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
#     "https://accounts.google.com/*",
# )
config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")
c.content.local_content_can_access_remote_urls = True
config.set(
    "content.local_content_can_access_remote_urls",
    True,
    "file:///~/.local/share/qutebrowser/userscripts/*",
)
config.set(
    "content.local_content_can_access_file_urls",
    False,
    "file:///~/.local/share/qutebrowser/userscripts/*",
)
c.content.notifications.enabled = True
c.content.pdfjs = True
c.content.plugins = True
c.content.tls.certificate_errors = "load-insecurely"
c.content.webgl = True
c.content.xss_auditing = False
c.completion.height = "30%"
c.downloads.position = "bottom"
c.downloads.prevent_mixed_content = True
c.hints.padding = {"left": 4, "right": 4, "top": 3, "bottom": 4}
c.hints.radius = 7
c.input.insert_mode.auto_load = True
c.input.insert_mode.auto_leave = True
c.prompt.filebrowser = False
c.tabs.favicons.scale = 1.4
c.tabs.last_close = "close"
c.tabs.padding = {"left": 5, "right": 3, "top": 3, "bottom": 4}
c.tabs.show_switching_delay = 700
c.tabs.title.format = "{audio}{current_title}"
c.tabs.indicator.width = 0
c.window.title_format = "{perc}{current_title}"
c.window.transparent = True
config.source("common.py")
config.source("binds.py")
config.source("theme.py")
