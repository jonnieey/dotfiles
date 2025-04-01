c.hints.selectors["all"] += [
    "label.upload-step",
    "div.radio-icon",
    "div.check-icon",
    "div.btn",
]
c.fileselect.multiple_files.command = [
    "st",
    "-e",
    "clifm",
    "--sel-file={}",
    "~/.local/share/transcriptor4/clients",
]
c.fileselect.single_file.command = [
    "st",
    "-e",
    "clifm",
    "--sel-file={}",
    "~/.local/share/transcriptor4/clients",
]
config.source("common.py")
config.source("binds.py")
config.source("theme.py")
