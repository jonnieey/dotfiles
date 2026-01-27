c.hints.uppercase = True
c.colors.webpage.darkmode.enabled = True
c.downloads.location.directory = "~/Downloads/qutebrowser"
c.downloads.location.prompt = False
c.fileselect.handler = "external"
c.fileselect.multiple_files.command = ["kitty", "clifm", "--sel-file={}"]
c.fileselect.single_file.command = ["kitty", "clifm", "--sel-file={}"]
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?ia=web&q={}",
    "au": "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}",
    "go": "https://google.com/search?hl=en&q={}",
    "!i": "https://yewtu.be/search?q={}",
    "ma": "https://google.com/maps?q={}",
    "wi": "https://en.wikipedia.org/w/index.php?title=Special%3ASearch&search={}",
    "gh": "https://github.com/search?q={}",
    "yo": "https://youtube.com/results?search_query={}",
    "ya": "https://yandex.ru/search/?text={}",
}
